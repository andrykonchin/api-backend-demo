class SessionsController < ApplicationController
  include WardenHelper

  before_action only: :create do
    unless params[:user][:email].present?
      render_errors(['Login Failed'], status: 401)
    end
  end

  def create
    user = User.find_by(email: params[:user][:email])

    if BCrypt::Password.new(user.encrypted_password) == params[:user][:password]
      device_session = user.device_sessions.create(authentication_token: generate_token(user))
      render_resource_or_errors(device_session)
    else
      render_errors(['Login Failed'], status: 401)
    end
  end

  def destroy
    authenticate!
    current_user.device_sessions.where(authentication_token: params[:authentication_token]).destroy_all
  end

  private

  def generate_token(user)
    Digest::SHA1.hexdigest("#{user.email}:#{friendly_token}#{Time.now()}")
  end

  def friendly_token
    SecureRandom.urlsafe_base64(15).tr('lIO0', 'sxyz')
  end
end

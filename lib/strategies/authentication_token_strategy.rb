require 'warden'

class AuthenticationTokenStrategy < ::Warden::Strategies::Base
  def valid?
    authentication_token
  end

  def authenticate!
    session = DeviceSession.find_by(authentication_token: authentication_token)
    user = session.user if session.present?
    user.nil? ? fail!('strategies.authentication_token.failed') : success!(user)
  end

  private

  # TODO Replace with Authorization HTTP header
  def authentication_token
    params['authentication_token']
  end
end

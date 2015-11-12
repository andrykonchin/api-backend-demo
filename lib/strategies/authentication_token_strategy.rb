require 'warden'
require File.expand_path('../../token_authentication', __FILE__)

class AuthenticationTokenStrategy < ::Warden::Strategies::Base
  def valid?
    authentication_token
  end

  def authenticate!
    session = DeviceSession.find_by(authentication_token: authentication_token.to_s)
    user = session.user if session.present?
    user.nil? ? fail!('strategies.authentication_token.failed') : success!(user)
  end

  private

  def authentication_token
    TokenAuthentication.token_from_request(request)
  end
end

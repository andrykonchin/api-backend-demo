# See details here:
# http://blog.maestrano.com/rails-api-authentication-with-warden-without-devise/

module WardenHelper
  extend ActiveSupport::Concern

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end

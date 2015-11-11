class PrivateApiController < ApplicationController
  include WardenHelper

  helper_method :warden, :signed_in?, :current_user
  prepend_before_filter :authenticate!
end

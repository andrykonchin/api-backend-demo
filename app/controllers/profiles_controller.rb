class ProfilesController < PrivateApiController
  def show
    render_resource_data(current_user)
  end
end

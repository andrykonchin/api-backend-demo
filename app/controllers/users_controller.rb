class UsersController < ApplicationController
  def create
    user = User.build(user_params.exclude(:password))
    user.encrypted_password = BCrypt::Password.create(user_params[:password])
    user.save
    render_resource_or_errors user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end

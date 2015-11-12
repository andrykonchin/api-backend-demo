class UsersController < ApplicationController
  def create
    user = User.new(user_params.except(:password))
    user.encrypted_password = BCrypt::Password.create(user_params[:password])
    user.save
    render_resource_or_errors(user, status: 201)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end

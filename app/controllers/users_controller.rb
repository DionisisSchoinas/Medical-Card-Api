# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  def create
    new_params = user_params
    new_params[:password] = params[:password] unless params[:password].nil?
    new_params[:password_confirmation] = params[:password_confirmation] unless params[:password_confirmation].nil?
    user = User.create!(new_params)
    result = AuthenticateUser.new(user.email, user.password).call
    user.create_patient!()
    response = { message: Message.account_created, auth_token: result[:auth_token], is_doctor: result[:is_doctor] }
    json_response(response, :created)
  end

  private

  def user_params
    params.require(:user).permit(
      :amka,
      :email,
      :fullname,
      :date_of_birth
    )
  end
end

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    result = AuthenticateUser.new(user.email, user.password).call
    user.create_patient!()
    response = { message: Message.account_created, auth_token: result[:auth_token], is_doctor: result[:is_doctor] }
    json_response(response, :created)
  end

  private

  def user_params
    raise(ActionController::ParameterMissing, 'password_confirmation') if params[:password_confirmation].nil?

    params.permit(
      :amka,
      :email,
      :password,
      :password_confirmation,
      :fullname,
      :date_of_birth
    )
  end
end

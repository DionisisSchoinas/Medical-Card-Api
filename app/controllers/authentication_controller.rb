# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    authenticated_user = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = { message: Message.logged_in, auth_token: authenticated_user[:auth_token], is_doctor: authenticated_user[:is_doctor] }
    json_response(response)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end

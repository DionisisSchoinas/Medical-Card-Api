# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = { message: Message.logged_in, auth_token: auth_token }
    json_response(response)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end

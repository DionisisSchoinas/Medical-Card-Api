# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token and whether or not user is a doctor once user is authenticated
  def authenticate
    authenticated_user = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = { message: Message.logged_in, auth_token: authenticated_user[:auth_token], is_doctor: authenticated_user[:is_doctor], doctor_id: authenticated_user[:doctor_id], fullname: authenticated_user[:fullname], date_of_birth: authenticated_user[:date_of_birth] }
    json_response(response)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end

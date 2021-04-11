class DoctorsController < ApplicationController
  def index
  end

  def create
    if current_user.doctor.nil?
      current_user.create_doctor!(doctor_params)
      current_user.doctor.create_image!(image_params) unless image_params[:image_base64].nil?
      response = { message: Message.doctor_account_created }
      json_response(response, :created)
    else
      json_response({ message: Message.doctor_account_exists }, 422)
    end
  end

  private

  def doctor_params
    params.permit(
      :speciality,
      :office_address,
      :phone,
      :email,
      :cost
    )
  end

  def image_params
    params.permit(:image_base64)
  end
end

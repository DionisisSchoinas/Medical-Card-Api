class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update]

  # GET /doctors
  def index
    doctors = Doctor.all
    json_response(doctors, :ok, ['doctor', 'user'], ['id', 'cost', 'speciality'])
  end

  # POST /doctors
  def create
    if image_params[:image_base64].nil?
      raise(ActionController::ParameterMissing, 'image_base64')
    else
      current_user.create_doctor!(doctor_params)
      current_user.doctor.create_image!(image_params)
      json_response({ message: Message.doctor_account_created }, :created)
    end
  end

  # GET /doctors/:id
  def show
    json_response(@doctor)
  end

  # PUT /doctors/:id
  def update
    if current_user[:id] == @doctor[:user_id]
      @doctor.update(doctor_params)
      @doctor.image.update(image_params) unless image_params[:image_base64].nil?
      json_response(@doctor)
    else
      json_response({ message: Message.unauthorized }, :unauthorized)
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(
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

  def set_doctor
    @doctor = Doctor.find(params[:id]) if params[:id]
  end
end

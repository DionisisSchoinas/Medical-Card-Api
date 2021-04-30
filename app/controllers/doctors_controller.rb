class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show]
  before_action :set_current_doctor, only: [:index_current, :update_current ]

  # GET /doctor
  def index_current
    if @doctor.nil?
      json_response({ message: Message.unauthorized }, status: :unauthorized)
    else
      json_response(@doctor, include: ['user', 'image'])
    end
    #doctors = Doctor.all
    #doctors = doctors.where('LOWER(speciality) LIKE :speciality', {speciality: "%#{params[:speciality_query].downcase}%" }) unless params[:speciality_query].nil?
    #doctors = doctors.page(page_params[:page]).per_page(page_params[:per_page])
    #json_response(doctors, include: ['doctor', 'user'], fields: ['id', 'cost', 'speciality', 'office_address'], meta: pagination_dict(doctors))
  end

  # GET /doctors
  def index
    doctors = Doctor.all
    doctors = doctors.where('LOWER(speciality) LIKE :speciality', {speciality: "%#{params[:speciality_query].downcase}%" }) unless params[:speciality_query].nil?
    doctors = doctors.page(page_params[:page]).per_page(page_params[:per_page])
    json_response(doctors, include: ['doctor', 'user'], fields: ['id', 'cost', 'speciality', 'office_address'], meta: pagination_dict(doctors))
  end

  # POST /doctors
  def create
    if image_params[:image_base64].nil?
      raise(ActionController::ParameterMissing, 'image_base64')
    else
      current_user.create_doctor!(doctor_params)
      current_user.doctor.create_image!(image_params)
      json_response({ message: Message.doctor_account_created }, status: :created)
    end
  end

  # GET /doctors/:id
  def show
    json_response(@doctor, include: ['user', 'image'])
  end

  # PUT /doctor
  def update_current
    if @doctor.nil?
      json_response({ message: Message.unauthorized }, status: :unauthorized)
    else
      @doctor.update(doctor_params)
      @doctor.image.update(image_params) unless image_params[:image_base64].nil?
      json_response(@doctor, include: ['user', 'image'])
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

  def set_current_doctor
    @doctor = current_user.doctor
  end

  def set_doctor
    @doctor = Doctor.find(params[:id]) if params[:id]
  end
end

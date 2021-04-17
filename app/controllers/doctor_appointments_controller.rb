class DoctorAppointmentsController < ApplicationController
  before_action :set_doctor
  before_action :set_appointment, only: [:show]

  # GET /doctor/appointments
  def index
    appointments = @doctor.appointments.page(page_params[:page]).per_page(page_params[:per_page])
    json_response(appointments, include: ['patient.user'], meta: pagination_dict(appointments), each_serializer: AppointmentForDoctorSerializer)
  end

  # GET /doctor/appointments/:id
  def show
    json_response(@appointment, include: ['patient.user'], serializer: AppointmentForDoctorSerializer)
  end

  # GET /doctors/:doctor_id/appointments_simple or /doctor/appointments_simple
  def simple_list
    appointments = @doctor.appointments.page(page_params[:page]).per_page(page_params[:per_page]).order('appointment_date_time_start ASC')
    json_response(appointments, include: ['appointment.appointment_date_time_start', 'appointment.appointment_date_time_end'], meta: pagination_dict(appointments))
  end

  private

  def set_doctor
    @doctor = current_user.doctor unless current_user.doctor.nil? # Set doctor to current user doctor
    @doctor = Doctor.find(params[:doctor_id]) unless params[:doctor_id].nil? # Set doctor to given doctor
    raise(ExceptionHandler::AuthenticationError, Message.unauthorized) if @doctor.nil?
  end

  def set_appointment
    @appointment = @doctor.appointments.find_by!(id: params[:id]) if @doctor
  end
end

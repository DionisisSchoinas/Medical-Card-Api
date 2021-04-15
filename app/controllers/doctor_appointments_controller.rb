class DoctorAppointmentsController < ApplicationController
  before_action :set_doctor
  before_action :set_appointment, only: [:show]

  # GET /doctors/:doctor_id/appointments or /doctors/appointments
  def index
    appointments = @doctor.appointments
    json_response(appointments, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
  end

  # GET /doctors/:doctor_id/appointments/:id or /doctors/appointments/:id
  def show
    json_response(@appointment, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
  end

  # GET /doctors/:doctor_id/appointments_simple or /doctors/appointments_simple
  def simple_list
    appointments = @doctor.appointments.order('appointment_date_time_start ASC')
    json_response(appointments, :ok, ['appointment.appointment_date_time_start', 'appointment.appointment_date_time_end'])
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

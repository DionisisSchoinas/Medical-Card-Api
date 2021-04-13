class DoctorAppointmentsController < ApplicationController
  before_action :set_doctor
  before_action :set_appointment, only: [:show]

  # GET /doctors/:doctor_id/appointments
  def index
    appointments = @doctor.appointments
    json_response(appointments, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
  end

  # GET /doctors/:doctor_id/appointments/:id
  def show
    json_response(@appointment, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
  end

  # GET /doctors/:doctor_id/appointments_simple
  def simple_list
    appointments = @doctor.appointments.order('appointment_date_time_start ASC')
    json_response(appointments, :ok, ['appointment.appointment_date_time_start', 'appointment.appointment_date_time_end'])
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def set_appointment
    @appointment = @doctor.appointments.find_by!(id: params[:id]) if @doctor
  end
end

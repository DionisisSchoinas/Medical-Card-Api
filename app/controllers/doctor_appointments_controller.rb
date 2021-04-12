class DoctorAppointmentsController < ApplicationController
  before_action :set_doctor
  before_action :set_appointment, only: [:show]

  # GET /doctors/:doctor_id/appointments
  def index
    appointments = @doctor.appointments
    json_response(appointments, :ok, ['doctor', 'patient.user'])
  end

  # GET /doctors/:doctor_id/appointments/:id
  def show
    json_response(@appointment, :ok, ['doctor', 'patient.user'])
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def set_appointment
    @appointment = @doctor.appointments.find_by!(id: params[:id]) if @doctor
  end
end

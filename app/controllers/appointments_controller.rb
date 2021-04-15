class AppointmentsController < ApplicationController
  before_action :set_patient
  before_action :set_appointment, only: [:show, :destroy]

  # GET /appointments
  def index
    appointments = @patient.appointments
    json_response(appointments, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
  end

  # POST /appointments
  def create
    new_appointment = @patient.appointments.create!(appointment_params)
    #----------------
    # => Send push notification to devices
    #----------------
    json_response({ message: Message.appointment_booked_successfully }, :created)
  end

  # GET /appointments/:id
  def show
    json_response(@appointment, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
  end

  # DELETE /appointments/:id
  def destroy
    @appointment.destroy
    #----------------
    # => Send push notification to devices
    #----------------
    head :no_content
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date_time_start, :appointment_date_time_end, :doctor_id)
  end

  def set_patient
    @patient = current_user.patient
  end

  def set_appointment
    @appointment = @patient.appointments.find_by!(id: params[:id]) if @patient
  end
end

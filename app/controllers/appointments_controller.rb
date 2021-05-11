class AppointmentsController < ApplicationController
  require 'fcm'

  before_action :set_patient
  before_action :set_appointment, only: [:show, :destroy]
  before_action :set_fcm, only: [:create, :destroy]

  # GET /appointments
  def index
    appointments = @patient.appointments.where('appointment_date_time_start >= :today', {today: Date.today.beginning_of_day}).order('appointment_date_time_start ASC').page(page_params[:page]).per_page(page_params[:per_page])
    json_response(appointments, include: ['doctor.user'], meta: pagination_dict(appointments))
  end

  # POST /appointments
  def create
    new_appointment = @patient.appointments.create!(appointment_params)
    #----------------
    # => Send push notification to devices
    #----------------
    topic = new_appointment.doctor.id
    response1 = @fcm.send_to_topic(topic.to_s, notification: {body: "CREATE"}, data: {id: new_appointment.id, appointment_date_time_start: new_appointment.appointment_date_time_start, appointment_date_time_end: new_appointment.appointment_date_time_end} )
    response2 = @fcm.send_to_topic('extra'+topic.to_s, notification: {body: "CREATE"}, data: {id: new_appointment.id, appointment_date_time_start: new_appointment.appointment_date_time_start, appointment_date_time_end: new_appointment.appointment_date_time_end, patient_fullname: @patient.user.fullname } )

    json_response({ message: Message.appointment_booked_successfully }, status: :created)
  end

  # GET /appointments/:id
  def show
    json_response(@appointment, include: ['doctor.user', 'doctor.image'], serializer: SingleAppointmentSerializer)
  end

  # DELETE /appointments/:id
  def destroy
    #----------------
    # => Send push notification to devices
    #----------------
    topic = @appointment.doctor.id
    response1 = @fcm.send_to_topic(topic.to_s, notification: {body: "DELETE"}, data: {id: @appointment.id, appointment_date_time_start: @appointment.appointment_date_time_start} )
    response2 = @fcm.send_to_topic('extra'+topic.to_s, notification: {body: "DELETE"}, data: {id: @appointment.id, appointment_date_time_start: @appointment.appointment_date_time_start} )

    @appointment.destroy

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

  def set_fcm
    @fcm = FCM.new(Rails.application.credentials.firebase_messaging_key)
  end
end

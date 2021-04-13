class QrCodesController < ApplicationController
  before_action :set_patient, only: [:generate]
  before_action :set_doctor, only: [:read]

  # GET qr/generate
  def generate
    token = JsonWebToken.encode({ patient_id: @patient[:id] }, 5.minutes.from_now)
    json_response({ expires_after_seconds: 5 * 60, token: token })
  end

  # POST qr/read
  def read
    if current_user.doctor.nil?
      json_response({ message: Message.unauthorized }, :unauthorized)
    else
      data = JsonWebToken.decode(token)
      appointment = Appointment.where('doctor_id == :doctor_id AND patient_id == :patient_id AND (appointment_date_time_start >= :time_now OR appointment_date_time_end <= :time_now)', {doctor_id: @doctor[:id], patient_id: data[:patient_id], time_now: Time.now.to_i}).order('appointment_date_time_start asc').limit(1)
      json_response(appointment, :ok, ['doctor.user', 'doctor.image', 'patient.user'])
    end
  end

  private

  def token
    params.permit(:token).require(:token)
  end

  def set_patient
    @patient = current_user.patient
  end

  def set_doctor
    @doctor = current_user.doctor
  end
end

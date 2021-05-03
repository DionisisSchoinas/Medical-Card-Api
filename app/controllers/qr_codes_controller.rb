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
      json_response({ message: Message.unauthorized }, status: :unauthorized)
    else
      data = JsonWebToken.decode_qr(token)
      appointment = @doctor.appointments.where('patient_id = :patient_id AND (appointment_date_time_start >= :time_now OR (appointment_date_time_start <= :time_now AND :time_now <= appointment_date_time_end) )', {patient_id: data[:patient_id], time_now: Time.now}).order('appointment_date_time_start ASC').limit(1)

      # If no current or future appointments, try to get the last one (no appointment id required)
      if appointment[0].nil?
        prev_appointment = @doctor.appointments.where('patient_id = :patient_id', {patient_id: data[:patient_id]}).order('appointment_date_time_start desc').limit(1)
      else
        prev_appointment = @doctor.appointments.where('patient_id = :patient_id AND appointment_date_time_start < :time_start', {patient_id: data[:patient_id], time_start: appointment[0][:appointment_date_time_start] }).order('appointment_date_time_start desc').limit(1)
      end

      prev_reponse = { prev_appointment: {} }
      prev_reponse[:prev_appointment][:appointment_date_time_start] = prev_appointment[0][:appointment_date_time_start] unless prev_appointment[0].nil?

      # Keep the same format for the response no matter what data it has
      if appointment[0].nil?
        json_response( { appointment: {}, meta: prev_reponse } )
      else
        json_response(appointment[0], include: ['patient.user'], meta: prev_reponse)
      end
    end
  end

  private

  def token
    params.require(:token)
  end

  def set_patient
    @patient = current_user.patient
  end

  def set_doctor
    @doctor = current_user.doctor
  end
end

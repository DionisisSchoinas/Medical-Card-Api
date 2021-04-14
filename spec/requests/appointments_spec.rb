require 'rails_helper'

RSpec.describe 'Appointments API' do
  # Initialize the test data
  let!(:user1) { create(:user)}
  let!(:user) { create(:user)}
  let!(:doctor) { create(:doctor, user_id: user1.id) }
  let!(:patient) { create(:patient, user_id: user.id) }
  let!(:appointments) { create_list(:appointment, 20, doctor_id: doctor.id, patient_id: patient.id) }
  let(:doctor_id) { doctor.id }
  let(:patient_id) { patient.id }
  let(:id) { appointments.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /patients/:patient_id/appointments
  describe 'GET /patients/:patient_id/appointments' do
    before { get "/patients/#{patient_id}/appointments", params: {}, headers: headers }

    context 'when patient exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all patient\'s appointments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when patient does not exist' do
      let(:patient_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Patient/)
      end
    end
  end

  # Test suite for GET /patients/:patient_id/appointments/:id
  describe 'GET /patients/:patient_id/appointments/:id' do
    before { get "/patients/#{patient_id}/appointments/#{id}", params: {}, headers: headers }

    context 'when patient appointment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the appointment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when patient appointment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  # Test suite for POST /patients/:patient_id/appointments
  describe 'POST patients/:patient_id/appointments' do
    let(:valid_attributes) do
      {
        appointment: { appointment_date_time_start: Time.now.utc + 24.hours, appointment_date_time_end: Time.now.utc + 25.hours, doctor_id: doctor_id, patient_id: patient_id }
      }.to_json
    end
    let(:too_early_params) do
      {
        appointment: { appointment_date_time_start: Time.now.utc, appointment_date_time_end: Time.now.utc + 1.hours, doctor_id: doctor_id, patient_id: patient_id }
      }.to_json
    end
    let(:end_too_early_params) do
      {
        appointment: { appointment_date_time_start: Time.now.utc + 24.hours, appointment_date_time_end: Time.now.utc + 23.hours, doctor_id: doctor_id, patient_id: patient_id }
      }.to_json
    end

    context 'when request attributes are valid' do
      before { post "/patients/#{patient_id}/appointments", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/patients/#{patient_id}/appointments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/param is missing or the value is empty: appointment/)
      end
    end

    context 'when date time start earlier than 6 hours on UTC' do
      before { post "/patients/#{patient_id}/appointments", params: too_early_params, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Appointment date time start must be at least 6 hours after the current time in UTC/)
      end
    end

    context 'when date time end earlier than date time start' do
      before { post "/patients/#{patient_id}/appointments", params: end_too_early_params, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Appointment date time end must be later than Appointment date time start/)
      end
    end
  end

  # Test suite for DELETE /patients/:patient_id/appointments/:id
  describe 'DELETE /patients/:patient_id/appointments/:id' do
    before { delete "/patients/#{patient_id}/appointments/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

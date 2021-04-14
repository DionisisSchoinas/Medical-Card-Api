require 'rails_helper'

RSpec.describe 'QR Codes API', type: :request do
  let!(:user) { create(:user)}
  let!(:user2) { create(:user)}
  let!(:doctor) { create(:doctor, user_id: user.id) }
  let!(:patient) { create(:patient, user_id: user2.id) }

  # Test suite for GET /qr/generate
  describe 'GET /qr/generate' do
    let(:headers) do
      {
        Authorization_Token: token_generator(patient.user.id),
        "Content-Type" => "application/json"
      }
    end
    before { get "/qr/generate", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns token for QR' do
      expect(json['token']).not_to be_nil
    end
  end

  # Test suite for GET /qr/read
  describe 'POST /qr/read' do
    let(:appointment) { create(:appointment, appointment_date_time_start: 10.days.from_now, doctor_id: doctor.id, patient_id: patient.id) }
    let(:valid_headers) do
      {
        Authorization_Token: token_generator(doctor.user.id),
        "Content-Type" => "application/json"
      }
    end
    let(:invalid_headers) do
      {
        Authorization_Token: token_generator(patient.user.id),
        "Content-Type" => "application/json"
      }
    end
    let(:token) do
      {
        token: qr_token_generator(patient.id)
      }.to_json
    end
    let(:expired_token) do
      {
        token: expired_qr_token_generator(patient.id)
      }.to_json
    end

    context 'when current user is a doctor' do
      context 'and has a valid token' do
        before { post "/qr/read", params: token, headers: valid_headers }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'and has an expired token' do
        before { post "/qr/read", params: expired_token, headers: valid_headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns appointment information' do
          expect(response.body).to match(/Signature has expired/)
        end
      end

      context 'and doesn\'t have token' do
        before { post "/qr/read", params: {}, headers: valid_headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns appointment information' do
          expect(response.body).to match(/param is missing or the value is empty: token/)
        end
      end
    end

    context 'when current user is not a doctor' do
      before { post "/qr/read", params: {}, headers: invalid_headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns Unauthorized request message' do
        expect(response.body).to match(/Unauthorized request/)
      end
    end
  end
end

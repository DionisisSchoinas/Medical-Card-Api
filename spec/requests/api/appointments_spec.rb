require 'swagger_helper'

RSpec.describe 'Appointments API', type: :request do
  #Method : GET
  #Path   : /appointments
  #Title  : Gets patient's appointments
  path '/appointments' do
    get 'Gets patient\'s appointments' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      response '200', 'returns all patient\'s appointments' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'patient not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : GET
  #Path   : /appointments/:id
  #Title  : Gets patient's appointment
  path '/appointments/{id}' do
    get 'Gets patient\'s appointment' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'returns patient\'s appointment' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'patient or appointment not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : POST
  #Path   : /appointments
  #Title  : Creates an appointment
  path '/appointments' do
    post 'Creates an apoointment' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string

      parameter in: :body, schema: {
        type: :object,
        properties: {
          appointment_date_time_start: { type: :string, format: 'date-time' },
          appointment_date_time_end: { type: :string, format: 'date-time' },
          doctor_id: { type: :number }
        },
        required: [ 'appointment_date_time_start', 'appointment_date_time_end', 'doctor_id' ]
      }

      response '201', 'appointment created' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : DELETE
  #Path   : /appointments/:id
  #Title  : Deletes patient's appointment
  path '/appointments/{id}' do
    delete 'Deletes patient\'s appointment' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '204', 'returns no content' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'patient or appointment not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end

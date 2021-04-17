require 'swagger_helper'

RSpec.describe 'Doctor Appointments API', type: :request do
  #Method : GET
  #Path   : /doctors/:doctor_id/appointments
  #Title  : Gets doctor's appointments
  path '/doctors/{doctor_id}/appointments' do
    get 'Gets doctor\'s appointments' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :doctor_id, in: :path, type: :string
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      response '200', 'returns all doctor\'s appointments' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'doctor not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : GET
  #Path   : /doctors/:doctor_id/appointments/:id
  #Title  : Gets doctor's appointment
  path '/doctors/{doctor_id}/appointments/{id}' do
    get 'Gets doctor\'s appointment' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :doctor_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'returns doctor\'s appointment' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'doctor or appointment not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : GET
  #Path   : /doctors/:doctor_id/appointments_simple
  #Title  : Gets doctor's appointments with less data
  path '/doctors/{doctor_id}/appointments_simple' do
    get 'Gets doctor\'s appointments (only dates)' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :doctor_id, in: :path, type: :string
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      response '200', 'returns all doctor\'s appointments (only dates)' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'doctor not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : GET
  #Path   : /doctors/appointments
  #Title  : Gets doctor's appointments
  path '/doctor/appointments' do
    get 'Gets logged in doctor\'s appointments' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      response '200', 'returns all doctor\'s appointments' do
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

  #Method : GET
  #Path   : /doctors/appointments/:id
  #Title  : Gets doctor's appointment
  path '/doctor/appointments/{id}' do
    get 'Gets logged in doctor\'s appointment' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'returns doctor\'s appointment' do
        run_test!
      end

      response '401', 'authorization failed' do
        run_test!
      end

      response '404', 'appointment not found' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : GET
  #Path   : /doctors/appointments_simple
  #Title  : Gets doctor's appointments with less data
  path '/doctor/appointments_simple' do
    get 'Gets logged in doctor\'s appointments (only dates)' do
      tags 'Appointment'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      response '200', 'returns all doctor\'s appointments (only dates)' do
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
end

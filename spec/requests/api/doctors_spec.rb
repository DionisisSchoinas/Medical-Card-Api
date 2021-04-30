require 'swagger_helper'

RSpec.describe 'Doctors API', type: :request do
  #Method : GET
  #Path   : /doctors/
  #Title  : Gets all doctors
  path '/doctors' do
    get 'Gets all doctors' do
      tags 'Doctor'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string
      parameter name: :speciality_query, in: :query, type: :string

      response '200', 'returns all doctors' do
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
  #Path   : /doctors/:id
  #Title  : Gets currently logged in doctor
  path '/doctor' do
    get 'Gets currently logged in doctor' do
      tags 'Doctor'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string

      response '200', 'returns a doctor' do
        run_test!
      end

      response '401', 'user not a doctor or authorization failed' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : GET
  #Path   : /doctors/:id
  #Title  : Gets a doctor
  path '/doctors/{id}' do
    get 'Gets a doctor' do
      tags 'Doctor'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '200', 'returns a doctor' do
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

  #Method : POST
  #Path   : /doctors/
  #Title  : Creates a doctor
  path '/doctors' do
    post 'Creates a doctor' do
      tags 'Doctor'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter in: :body, schema: {
        type: :object,
        properties: {
          speciality: { type: :string },
          office_address: { type: :string },
          phone: { type: :string },
          email: { type: :string },
          cost: { type: :number, format: 'float' },
          image_base64: { type: :string }
        },
        required: [ 'speciality', 'office_address', 'phone', 'email', 'cost', 'image_base64' ]
      }

      response '201', 'doctor created' do
        #let(:doctor) { { speciality: 'speciality', office_address: 'office_address', phone: 'phone', email: 'email', cost: 50, image_base64: 'image_base64' } }
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

  #Method : PUT
  #Path   : /doctor
  #Title  : Updates currently logged in doctor
  path '/doctor' do
    put 'Updates currently logged in doctor' do
      tags 'Doctor'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter in: :body, schema: {
        type: :object,
        properties: {
          speciality: { type: :string },
          office_address: { type: :string },
          phone: { type: :string },
          email: { type: :string },
          cost: { type: :number },
          image_base64: { type: :string }
        }
      }

      response '200', 'returns updated doctor' do
        run_test!
      end

      response '401', 'current user not a doctor or authorization failed' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end

require 'swagger_helper'

RSpec.describe 'Doctors API', type: :request do

  #Method : Post
  #Path   : /doctors/
  #Title  : Creates a doctor
  path '/doctors' do
    post 'Creates a doctor' do
      tags 'Doctor'
      consumes 'application/json'

      parameter name: :Authorization_Token, in: :header, type: :string
      parameter in: :body, schema: {
        type: :object,
        properties: {
          speciality: { type: :string },
          office_address: { type: :string },
          phone: { type: :string },
          email: { type: :string },
          cost: { type: :double },
          image_base64: { type: :string }
        },
        required: [ 'speciality', 'office_address', 'phone', 'email', 'cost', 'image_base64' ]
      }

      response '201', 'doctor created' do
        let(:doctor) { { speciality: 'speciality', office_address: 'office_address', phone: 'phone', email: 'email', cost: 'cost', image_base64: 'image_base64' } }
        run_test!
      end

      response '422', 'invalid request' do
        #let(:blog) { { title: 'foo' } }
        run_test!
      end
    end
  end
end

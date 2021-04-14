require 'swagger_helper'

RSpec.describe 'QR Codes API', type: :request do
  #Method : GET
  #Path   : /qr/generate
  #Title  : Generates a token for current user
  path '/qr/generate' do
    get 'Generates a token for current user' do
      tags 'QR'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string

      response '200', 'returns a token' do
        #let(:user) { create(:user, :email, :password) }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  #Method : POST
  #Path   : /qr/read
  #Title  : Reads a token for current user
  path '/qr/read' do
    post 'Reads a token for current user' do
      tags 'QR'
      consumes 'application/json'
      parameter name: :AuthorizationToken, in: :header, type: :string
      parameter in: :body, schema: {
        type: :object,
        properties: {
          token: { type: :string }
        },
        required: [ 'token' ]
      }

      response '200', 'returns appointment information' do
        run_test!
      end

      response '401', 'unauthorized request (current user isn\'t a doctor)' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end

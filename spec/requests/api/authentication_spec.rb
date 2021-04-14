require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  #Method : POST
  #Path   : /auth/login
  #Title  : Login user
  path '/auth/login' do
    post 'Logs in a user' do
      tags 'Authentication'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'user logged in' do
        #let(:user) { create(:user, :email, :password) }
        run_test!
      end

      response '401', 'invalid credentials' do
        run_test!
      end
    end
  end
end

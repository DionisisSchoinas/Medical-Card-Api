require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  #Method : POST
  #Path   : /signup
  #Title  : Signup user
  path '/signup' do
    post 'Signs up a user' do
      tags 'User'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          amka: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          fullname: { type: :string },
          date_of_birth: { type: :string, format: 'date' }
        },
        required: [ 'amka', 'email', 'password', 'password_confirmation', 'fullname', 'date_of_birth' ]
      }

      response '201', 'creates a new user' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end

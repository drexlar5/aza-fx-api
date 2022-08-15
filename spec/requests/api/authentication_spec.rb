require 'swagger_helper'

RSpec.describe 'api/authentication', type: :request do
    path '/register' do

        post 'Creates a user' do
          tags 'Authentication'
          consumes 'application/json'
          produces 'application/json'
          parameter name: :params, in: :body, schema: {
            type: :object,
            properties: {
              email: { type: :string, example: 'johndoe@gmail.com' },
              password: { type: :string, example: 'password' }
            },
            required: [ 'email', 'password' ]
          }
    
          response '200', 'user created' do
            schema type: :object,
              properties: {
                user: {
                    type: :object,
                    properties: {
                        id: { type: :integer, example: 2 },
                        email: { type: :string, example: 'johndoe@gmail.com' },
                        user_id: { type: :string, example: '6f6cfa52-0e8b-44ab-9455-c6b8410aa0b0' },
                        password_digest: { type: :string, example: '$2a$12$3rCA9FkpCnfZ7ytbX5jSw.m7KfSsXyHNbuvIxPB2be8J9qdnTyVXW' },
                        created_at: { type: :string, example: '2022-08-15T23:21:10.516Z' },
                        updated_at: { type: :string, example: '2022-08-15T23:21:10.516Z' }
                    }
                }
            }

            let(:params) { {email: 'johndoe@gmail.com', password: 'password'}}

            run_test!
          end

          response '400', 'bad request' do
            schema type: :object,
            properties: {
                user_registration: { type: :string, example: 'user already exists' }
            }

            let(:user) {create(:user)}
            let(:params) {{email: user.email, password: 'unknown_password'}}

            run_test!
          end
        end
      end
    
      path '/authenticate' do
    
        post 'Authenticates a user' do
          tags 'Authentication'
          consumes 'application/json'
          produces 'application/json'
          parameter name: :params, in: :body, schema: {
            type: :object,
            properties: {
                email: { type: :string, example: 'johndoe@gmail.com' },
                password: { type: :string, example: 'password' }
            },
            required: [ 'email', 'password' ]
          }
    
          response '200', 'User authenticated' do
            schema type: :object,
              properties: {
                auth_token: { type: :string, example: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiOGJmZjE3MTktZDk2MC00M2QwLWJkZDUtNTlhMmU1NTg5YzEwIiwiZXhwIjoxNjYwNjg4MTY2fQ.VBpE-aqzeo7nYE2IvXj2y89-tHMmYNleZ1Mh7n6gcjE' }
              }

            let(:user) {create(:user)}
            let(:params) {{email: user.email, password: 'unknown_password'}}

            run_test!
          end
    
    
          response '401', 'invalid credentials' do
            schema type: :object,
            properties: {
                user_authentication: { type: :string, example: 'invalid credentials' }
            }

            let(:params) {{email: 'unknown_user@gmail.com', password: 'wrong_password'}}

            run_test!
          end
        end
      end
end

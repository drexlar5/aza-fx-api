require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
    let(:params) do
        {
        email: 'person+1@gmail.com',
        password: 'random_password',
        }
    end
    
    describe '#register' do
        it 'should register a user' do
            uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

            post :register, params: params
            response_body = JSON.parse(response.body)
           
            expect(response).to have_http_status(:ok)
            expect(response_body['user']['email']).to eq('person+1@gmail.com')
            expect(response_body['user']).to include('user_id')
            expect(response_body['user']['user_id']).to match uuid_regex
        end

        it 'should not register duplicate user' do
            post :register, params: params
            post :register, params: params
            response_body = JSON.parse(response.body)

            expect(response).to have_http_status(:bad_request)
            expect(response_body['error']['user_registration']).to eq('user already exists')
        end
    end

    describe '#authenticate' do
        it 'should authenticate a user' do
            post :register, params: params
            post :authenticate, params: params
            response_body = JSON.parse(response.body)

            expect(response).to have_http_status(:ok)
            expect(response_body['auth_token']).to start_with('eyJhbGciOiJIUzI1NiJ9')
        end

        it 'should not authenticate a user' do
            post :authenticate, params: params
            response_body = JSON.parse(response.body)

            expect(response).to have_http_status(:unauthorized)
            expect(response_body['error']['user_authentication']).to eq('invalid credentials')
        end
    end
end
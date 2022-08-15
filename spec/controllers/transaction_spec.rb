require 'rails_helper'

RSpec.describe Transactions::TransactionController, type: :controller do
    include UserAuthenticationHelper
    let(:params) do
        {
            transaction: {
                input_amount: 100,
                input_currency: 'USD',
                output_currency: 'NGN'
            }
        }
    end
    let(:user) {create(:user)}

    def create_transaction
        post :create, params: params
        response
    end

    describe '#create' do

        it 'should throw an error if not authenticated' do
            response = create_transaction
            response_body = JSON.parse(response.body)

            expect(response).to have_http_status(:unauthorized)
            expect(response_body['error']).to eq('Not Authorized')
        end

        it 'should create a transaction' do
            uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

            confirm_and_login_user(user)

            create_traresponse = create_transaction
            response_body = JSON.parse(response.body)

            should permit(:input_amount, :input_currency, :output_currency).
                for(:create, params: params).
                on(:transaction)

            expect(response).to have_http_status(:ok)
            expect(response_body).to include('user_id', 'transaction_id', 'input_amount', 'input_currency', 'output_amount', 'output_currency', 'created_at')
            expect(response_body['transaction_id']).to match uuid_regex
            expect(response_body['user_id']).to match user.user_id
            expect(response_body['input_currency'].length).to eq(3)
            expect(response_body['output_currency'].length).to eq(3)
        end

    end

    describe '#show' do
        it 'should show a single transaction' do
            uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

            confirm_and_login_user(user)

            transaction = JSON.parse(create_transaction.body)
            get :show, params: { id: transaction['transaction_id'] }
            response_body = JSON.parse(response.body)

            expect(response).to have_http_status(:ok)
            expect(response_body['transaction_id']).to match uuid_regex
            expect(response_body['user_id']).to match user.user_id
            expect(response_body['input_currency'].length).to eq(3)
            expect(response_body['output_currency'].length).to eq(3)
        end
    end

    describe '#index' do
        it 'show list of trancactions for a user' do
            uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

            confirm_and_login_user(user)

            create_transaction
            create_transaction
            create_transaction

            get :index
            response_body = JSON.parse(response.body)

            expect(response).to have_http_status(:ok)
            expect(response_body.length).to eq(3)
        end
    end
end
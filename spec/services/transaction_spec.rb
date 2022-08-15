require 'rails_helper'

RSpec.describe TransactionService, type: :service do
    let(:params) do
        {
            input_amount: 100,
            input_currency: 'USD',
            output_currency: 'NGN',
        }
    end
    let(:user) {create(:user)}

    def create_a_transaction(user, params)
        TransactionService.new(user).create_transaction(params)
    end

    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
    
    describe '#create_transaction' do

        it 'should create a transaction' do
            response = create_a_transaction(user, params)

            expect(response.to_json).to include('id', 'user_id', 'transaction_id', 'input_amount', 'input_currency', 'output_amount', 'output_currency', 'created_at')
            expect(response['transaction_id']).to match uuid_regex
            expect(response['user_id']).to match user.user_id
            expect(response['input_currency'].length).to eq(3)
            expect(response['output_currency'].length).to eq(3)
        end
    end

    describe '#show_all_transactions' do

        it 'should show all transactions for a user' do
            create_a_transaction(user, params)
            create_a_transaction(user, params)
            create_a_transaction(user, params)

            response = TransactionService.new(user).show_all_transactions

            expect(response.to_json).to include('user_id', 'transaction_id', 'input_amount', 'input_currency', 'output_amount', 'output_currency', 'created_at')
            expect(response[0]['user_id']).to match(response[1]['user_id'])
            expect(response.length).to eq(3)
        end
    end

    describe '#show_transaction' do

        it 'should show a single transaction' do
            transaction = create_a_transaction(user, params)

            response = TransactionService.new(user).show_transaction(transaction.transaction_id)

            expect(response).to include('user_id', 'transaction_id', 'input_amount', 'input_currency', 'output_amount', 'output_currency', 'created_at')
            expect(response['transaction_id']).to match uuid_regex
            expect(response['user_id']).to match user.user_id
            expect(response['input_currency'].length).to eq(3)
            expect(response['output_currency'].length).to eq(3)
        end
    end
end
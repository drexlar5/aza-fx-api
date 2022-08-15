require 'swagger_helper'

RSpec.describe 'api/transactions/transaction', type: :request do
    let(:user) { create(:user) }
    let(:token) {JsonWebToken.encode({ user_id: user.user_id })}
    let(:Authorization) { 'Bearer ' + token }

    path '/transactions' do
        post 'Creates a transaction' do
          tags 'Transactions'
          consumes 'application/json'
          produces 'application/json'
          security [bearer_auth: []]
          parameter name: :params, in: :body, schema: {
            type: :object,
            properties: {
              input_amount: { type: :integer, example: 100 },
              input_currency: { type: :string, example: 'USD' },
              output_currency: { type: :string, example: 'NGN' }
            },
            required: [ 'input_amount', 'input_currency', 'output_currency' ]
          }
    
          response '200', 'transaction created' do
            schema type: :object,
                properties: {
                    id: { type: :integer, example: 2 },
                    user_id: { type: :string, example: "8bff1719-d960-43d0-bdd5-59a2e5589c10" },
                    transaction_id: { type: :string, example: "1f35c83a-0be4-4b1e-b98b-50f278dc874d" },
                    input_amount: { type: :string, example: "100.0" },
                    input_currency: { type: :string, example: "USD" },
                    output_amount: { type: :string, example: "42331.89742" },
                    output_currency: { type: :string, example: "NGN" },
                    created_at: { type: :string, example: "2022-08-15T22:32:11.049Z" },
                    updated_at: { type: :string, example: "2022-08-15T22:32:11.049Z" }
                }

            let(:params) {{input_amount: 10, input_currency: 'EUR', output_currency: 'USD'}}

            run_test!
          end
        end
    end
    
    path '/transactions/{id}' do
    
        get 'Retrieves a transaction' do
          tags 'Transactions'
          produces 'application/json'
          security [bearer_auth: []]
          parameter name: :id, in: :path, type: :string
    
          response '200', 'transaction found' do
            schema type: :object,
              properties:  {
                id: { type: :integer, example: 2 },
                user_id: { type: :string, example: "8bff1719-d960-43d0-bdd5-59a2e5589c10" },
                transaction_id: { type: :string, example: "1f35c83a-0be4-4b1e-b98b-50f278dc874d" },
                input_amount: { type: :string, example: "100.0" },
                input_currency: { type: :string, example: "USD" },
                output_amount: { type: :string, example: "42331.89742" },
                output_currency: { type: :string, example: "NGN" },
                created_at: { type: :string, example: "2022-08-15T22:32:11.049Z" },
                updated_at: { type: :string, example: "2022-08-15T22:32:11.049Z" }
              }

            let(:transaction) { create(:transaction, user_id: user.user_id) }
            let(:id) { transaction.transaction_id }

            run_test!
          end
    
          response '404', 'transaction not found' do
            schema type: :object,
            properties:  {
                error: { type: :string, example: "transaction not found"}
            }

            let(:id) { 'wrong_id' }

            run_test!
          end
        end
      end

    path '/transactions' do
    
        get 'Retrieves all user transactions' do
          tags 'Transactions'
          produces 'application/json'
          security [bearer_auth: []]
          response '200', 'transactions found' do
            schema type: :array,
              items: {
                 type: :object,
                    properties:  {
                    id: { type: :integer, example: 2 },
                    user_id: { type: :string, example: "8bff1719-d960-43d0-bdd5-59a2e5589c10" },
                    transaction_id: { type: :string, example: "1f35c83a-0be4-4b1e-b98b-50f278dc874d" },
                    input_amount: { type: :string, example: "100.0" },
                    input_currency: { type: :string, example: "USD" },
                    output_amount: { type: :string, example: "42331.89742" },
                    output_currency: { type: :string, example: "NGN" },
                    created_at: { type: :string, example: "2022-08-15T22:32:11.049Z" },
                    updated_at: { type: :string, example: "2022-08-15T22:32:11.049Z" }
                }
              }

            run_test!
          end
        end
      end
end

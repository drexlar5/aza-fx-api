FactoryBot.define do
    factory :transaction do
        association :user

        transaction_id '1f35c83a-0be4-4b1e-b98b-50f278dc874g'
        input_amount 10
        input_currency 'CAD'
        output_amount 100
        output_currency 'NGN'
    end
end
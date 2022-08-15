FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "person+#{n}@gmail.com"}
        password 'unknown_password'
        user_id '01406800-efe9-4aaf-ba1d-fde62991474e'
    end
end
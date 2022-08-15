class User < ApplicationRecord
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
    validates :user_id, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 5 }

    has_many :transactions, inverse_of: :user, class_name: "Transaction", primary_key: :user_id
end

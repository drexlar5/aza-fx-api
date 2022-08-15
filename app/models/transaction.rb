class Transaction < ApplicationRecord
    validates :input_amount, presence: true, numericality: true
    validates :input_currency, presence: true, format: {with: /[a-zA-Z]/, message: "Currency must be in this format: 'USD'"}, length: { is: 3 }

    validates :output_amount, presence: true, numericality: true
    validates :output_currency, presence: true, format: {with: /[a-zA-Z]/, message: "Currency must be in this format: 'USD'"}, length: { is: 3 }

    validates :user_id, presence: true
    validates :transaction_id, presence: true, uniqueness: true

    belongs_to :user, inverse_of: :transactions, optional: true
end

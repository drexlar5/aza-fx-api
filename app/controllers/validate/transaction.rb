module Validate
    class Transaction
      include ActiveModel::Validations
  
      attr_accessor :input_currency, :output_currency, :input_amount
  
      validates :input_currency, presence: true, format: {with: /[a-zA-Z]/, message: "Currency must be in this format: 'USD'"}, length: { is: 3 }
      validates :input_amount, presence: true, numericality: { only_integer: true }
      validates :output_currency, presence: true, format: {with: /[a-zA-Z]/, message: "Currency must be in this format: 'USD'"}, length: { is: 3 }
    
      def initialize(params={})
        @input_currency = params[:input_currency]
        @input_amount = params[:input_amount]
        @output_currency = params[:output_currency]
      end
  
    end
  end
class TransactionService
    def initialize(current_user)
      @user_id = current_user.user_id
    end
  
    def create_transaction(params)
        begin
            formatted_input_currency = params[:input_currency].upcase
            formatted_output_currency = params[:output_currency].upcase

            result = CurrencyConversionApi.convert(formatted_input_currency, params[:input_amount], formatted_output_currency)
            output_amount = result['rates'][formatted_output_currency]

            Transaction.create!(
                user_id: @user_id,
                input_amount: params[:input_amount],
                input_currency: formatted_input_currency,
                transaction_id: SecureRandom.uuid,
                output_amount: output_amount,
                output_currency: formatted_output_currency
            )
        rescue StandardError => e
            nil
        end
    end

    def show_all_transactions
        Transaction.where(
            user_id: @user_id
        ).as_json(:except => [:id, :updated_at])
    end

    def show_transaction(transaction_id)
        transaction = Transaction.find_by(
            user_id: @user_id,
            transaction_id: transaction_id
        ).as_json(:except => [:id, :updated_at])

        transaction
    end
end
  
class Transactions::TransactionController < ApplicationController
  
  def index
    render(
      json: TransactionService.new(current_user).show_all_transactions
    )
  end
  
  def show
    transaction = TransactionService.new(current_user).show_transaction(params[:id])

    if transaction
      render(
        json: transaction
      )
    else
      render(
        json: { error: "transaction not found" }, status: :not_found
      )
    end
  end

  def create
    :validate_transaction_params

    render(
      json: TransactionService.new(current_user).create_transaction(transaction_params)
    )
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :input_amount,
      :input_currency,
      :output_currency
    )
  end
end
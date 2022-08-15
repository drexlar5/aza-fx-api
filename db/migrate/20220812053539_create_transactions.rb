class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :user_id
      t.string :transaction_id
      t.decimal :input_amount
      t.string :input_currency
      t.decimal :output_amount
      t.string :output_currency

      t.timestamps
    end
  end
end

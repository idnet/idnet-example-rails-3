class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      # 2 digit decimal values and 10 digit max
      # from 0.00 to 9_9999_999.99 ... lol
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :currency, null: false
      t.string :usage, null: false
      t.string :transaction_unique_id
      t.string :status, null: false, default: 'pending'
      t.belongs_to :user
      t.datetime :timestamp
      t.timestamps
    end
  end
end

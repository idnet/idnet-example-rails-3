class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :access_token
      t.integer :token_expires, null: true, default: nil

      t.timestamps
    end
  end
end

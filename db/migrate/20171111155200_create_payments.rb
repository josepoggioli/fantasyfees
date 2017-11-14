class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.integer :user_league_id

      t.timestamps
    end
  end
end

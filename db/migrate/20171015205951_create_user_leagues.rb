class CreateUserLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :user_leagues do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :admin
      t.boolean :fee_payed

      t.timestamps
    end
  end
end

class CreateLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues do |t|
      t.string :name
      t.float :fee
      t.string :fee_due_date
      t.string :league_code

      t.timestamps
    end
  end
end

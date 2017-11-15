class RemoveFeePayedFromUserLeagues < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_leagues, :fee_payed, :boolean
  end
end

class ChangeFeeToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :leagues, :fee, :decimal, precision: 8, scale: 2
  end
end

class ChangeFeeDueDateToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :leagues, :fee_due_date, 'date USING CAST(fee_due_date AS date)'
  end
end

class ChangeGroupIdToLeagueId < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_leagues, :group_id, :league_id
  end
end

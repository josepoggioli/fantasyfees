class League < ApplicationRecord
  has_many :user_leagues
  has_many :users, through: :user_leagues

  validates :name, :fee, :fee_due_date, presence: true

  def code
    return league_code
  end

end

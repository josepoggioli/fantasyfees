class Payment < ApplicationRecord
  belongs_to :user_league

  def pretty_amount
    self.amount / 100
  end

end

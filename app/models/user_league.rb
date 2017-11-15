class UserLeague < ApplicationRecord
  belongs_to :user
  belongs_to :league 
  has_many :payments

  def total_payments
    total_payments = 0
    self.payments.each do |payment|
      total_payments = total_payments + (payment.amount/100)
    end
    return total_payments
  end

  def isFeePaid?
    if self.total_payments == self.league.fee || self.total_payments > self.league.fee
      return true
    else
      return false
    end
  end

end

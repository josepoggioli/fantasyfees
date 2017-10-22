class User < ApplicationRecord
  has_many :user_leagues
  has_many :leagues, through: :user_leagues
  has_secure_password

  validates :username, :first_name, :last_name, :email, presence: true
  validates :first_name,:last_name, length: {minimum: 2}
  validates :email, uniqueness: true
end

class User < ActiveRecord::Base
  has_many :user_rounds
  has_many :rounds, through: :user_rounds
  validates :name, presence: true, uniqueness: true
end

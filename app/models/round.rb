class Round < ActiveRecord::Base
  has_many :user_rounds
  has_many :users, through: :user_rounds  
  # validate :round_has_two_players

  # def round_has_two_players
  #   UserRounds.where()
  # end  

end

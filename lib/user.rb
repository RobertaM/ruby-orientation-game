class User
  attr_accessor :nickname, :name, :surname, :address, :player_points, :mail, :number, :captain, :team, :team_name

  def initialize()
    game = Game.new
  end
    
  def with_player_points?
    if @player_points >= 0
      return true
    end
  end    
    
  def with_valid_email?
    if @mail.include? '@'
      return true
    end
  end 

  def is_author_of game
    if game.author == self
      return true
    end
  end 
end


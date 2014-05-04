require_relative 'meta'
class User < Meta
  attr_accessor :nickname, :name, :surname, :address, :player_points, :mail, :number, :captain, :team, :team_name, :password

  class << self
    attr_accessor :logged_in_as
  end

  def initialize()
    game = Game.new
    player_points = 0
  end
  
  def attribute_is_not_empty attribute
    if @attribute.nil?
      return false
    else
      return true
    end
  end
    
  def with_valid_email mail
    if mail.include? '@'
      return true
    else
      return false
    end
  end 

  def user_have_a_team_with_a_name team
 #   if have_a_team
 #     @team = team.name
 #     return true
 #   else
 #     return false
 #   end
  end

  def author_of game
    if game.author == self
      return true
    end
  end 

  def captain_of team  #new
    if team.captain == self
      return true
    end
  end
  
  def can_get_points team
    team.players.each do |player|
      if player == self
        player_points =+ team.points / team.players.length - 1
        return true
      end
    end
    return false
  end

  def login 
    User.logged_in_as = self
  end

  def logout
    User.logged_in_as = nil
  end

end


require_relative 'accesing_database'
class User < AccessingDatabase
  attr_accessor :nickname, :name, :surname, :address, :player_points, :mail, :number, :captain, :team, :team_name, :password

  class << self
    attr_accessor :logged_in_as
  end

  def initialize()
    game = Game.new
    player_points = 0
  end
  
  def attribute_is_not_empty attribute
    if attribute.nil?
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

  def with_player_points?
    if player_points >= 0
      return true
    else
      return false
    end
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
    if team.points > 0
      team.players.each do |player|
        player.player_points =+ team.points / team.players.length - 1
      end
      return true
    else
      return false
    end
  end

  def login 
    User.logged_in_as = self
    return true
  end

  def logout
    User.logged_in_as = nil
    return true
  end

  def self.find_login_info(nickname, password)
   puts @units
   @units.each do |unit|
      if(nickname == unit.nickname && password == unit.password)
        unit.login
        puts "found"
        return true
      end
    end
    return false
  end

  def self.check_if_exists nickname
    users = User.load_all
    puts users
    users.each do |us|
      if(nickname == us.nickname)
        return true
      end
    end
    return false
  end
  
  def password_match password, password2
    if (password != password2)
      return false
    else 
      return true
    end
  end
end


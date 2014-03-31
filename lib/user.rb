class User
  attr_accessor :nickname, :name, :surname, :address, :player_points, :mail, :number, :captain, :team, :team_name

  def initialize()
    game = Game.new
  end
  
  def have_a_nickname?
    if @nickname.nil?
      return false
    else
      return true
    end
  end

  def have_a_name?
    if @name.nil?
      return false
    else
      return true
    end
  end
  
  def have_a_surname?
    if @surname.nil?
      return false
    else
      return true
    end
  end

  def have_an_address 
    if @address.nil?
      return false
    else
      return true
    end
  end

  def have_a_number
    if @number.nil?
      return false
    else
      return true
    end
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

  def have_a_team?
    if @team.nil?
      return false
    else
      return true
    end
  end

  def user_have_a_team_with_a_name team
    if have_a_team
      @team = team.name
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
    team.players.each do |player|
      if player == self
        player_points =+ team.points / team.players.length - 1
        return true
      end
    end
    return false
  end
end


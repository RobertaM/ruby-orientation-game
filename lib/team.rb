class Team
  attr_accessor :name, :players, :number_of_games_played, :active_team, :passive_team, :captain, :level_answers, :points

  def initialize
    @level_answers = []
  end

  def with_name?
    if name.nil?
      return false
    else
      return true
    end
  end 

  def with_team_members?
    if players.nil?
      return false
    else
      return true
    end
  end

  def with_captain?
    if captain.nil?
      return false
    else
      return true
    end
  end

  def with_points?
    if points.nil? || points < 0
      return false
    else
      return true
    end
  end
  def able_to_participate_in_a game 
  	if game.players.include? self
  		return true
    end
  end


  def can_pass_levels game  #pakeisti i last index
    for i in (0..game.levels.length - 1)
      if level_answers[i] == game.levels[i].answer
        game.levels[i].passed = true
      else
        return false
      end
    end  
    return true  
  end
  
  def can_win_game game
    game.levels.each do |level|
      if level.passed == false
        return false
      end
    end
    game.won = true
    number_of_games_played =+1
    return true  
  end

  def can_get_points game
    if game.won == true
      @points =+10
      return true
    end
    return false
  end

  def can_participate game
    game.push(self)
    return true  
  end
end


class Team
  attr_accessor :name, :players, :number_of_games_played, :active_team, :passive_team, :captain, :level_answers, :points

  def initialize
    @level_answers = []
  end
  def able_to_participate_in_a game 
  	if game.players.include? self
  		return true
    end
  end

  def can_pass_a_levels game  #pakeisti i last index
    for i in (0..game.levels.length - 1)
      if level_answers[i] == game.levels[i].answer
        game.levels[i].passed = true
      else
        break
      end
    end
    return true
  end
  
  def check_if_all_levels_passed game
    for i in (0..game.levels.length - 1)
      if game.levels[i].passed == false
        return false
      end
    end
    game.won = true
    number_of_games_played =+1
    return true  
  end

  def can_get_points_if_wins game
    if game.won == true
      @points =+10
      return true
    end
    return false
  end

  def can_participate_in_a_game game
    @game.push(self)
    return true  
  end
end

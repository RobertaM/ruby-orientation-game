require_relative 'accesing_database'
require_relative 'user'
class Team < AccessingDatabase
  attr_accessor :name, :players, :number_of_games_played, :active_team, :passive_team, :captain, :level_answers, :points

  def initialize
    @level_answers = []
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

  def can_get_points won_points
    team_points = won_points
    players.each do |player| 
      player.player_points = team_points / players.length
    end
    team_points = 0

    if won_points > 0
      return true
    else 
      return false
    end
  end

  def can_participate game
    game.push(self)
    return true  
  end

  def with_points?
    if points >= 0
      return true
    else 
      return false
    end
  end
  
  def count_games_played game
    if !game.nil?
      number_of_games_played =+ 1
      return true
    else
      return false
    end
  end

  def check_team teams
    teams.each do |db_team|
      puts db_team
      if (User.logged_in_as.team == db_team)
        return db_team        
      end
    end
    return false
  end

  def already_a_member member
    if User.logged_in_as.team.players.include? member
      return true
    else
      return false
    end
  end
end

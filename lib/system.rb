class System
  attr_accessor :users, :games, :teams
  
  def initialize
    @users = []
    @games = []
    @teams = []
  end

  def adds_to_users_list user
    if user.nil?
      return false
    else
      @users.push(user)
      return true
    end
  end

  def adds_to_teams_list team
  	if team.nil?
  	  return false
  	else
      @team.push(team)
      return true
    end
  end

  def adds_to_games_list game
  	if game.nil?
  	  return false
  	else
  	  @games.push(game)
  	  return true
  	end
  end

  def delete_user_from_list user
    if user.nil?
      return false
    else
      @users.delete(user)
      return true
    end
  end

  def delete_team_from_list team
  	if team.nil?
      return false
  	else
      @teams.delete(team)
      return true
    end
  end

  def delete_game_from_list game
  	if game.nil?
  	  return false
  	else
  	  @games.delete(game)
  	  return true
    end
  end
end

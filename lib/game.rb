require_relative 'accesing_database'
class Game < AccessingDatabase
  attr_accessor :name, :author, :category, :real, :points, :available, :complexity, :information, :start_time, :end_time, :players, :levels, :won , :passed, :forum

  def initialize
    @category = :real
    @levels = []
    @won = false
    @players = []
    @passed = []
    @forum = []
    @available = false
    @complexity = 1
  end


  def valid_time
    @start_time > Time.now
  end

  def valid_end_time 
    if @start_time > Time.now and @end_time > @start_time
      return true
    end
  end


  def complex?
    if @complexity < 7
      return false
    else
      return true
    end
  end

  def categorised
    return category
  end

  def valid
    return available
  end

  def check_if_level_exists level
    if levels.include? level
      return true
    else 
      return false
    end
  end 

  def add_level level
    if !level.nil?
      @levels.push(level)
      return true
    else 
      return false
    end    
  end

  def add_team team 
    if !team.nil?
      players.push(@team)
      return true
    else 
      return false
    end
  end

  def participaiting_teams
    return players 
  end

  def give_points_to_winner levels_length
    if levels_length == 0
      return 0
    else
      game_points = levels_length * complexity.to_i
      return game_points
    end
  end

  def creator_of_game game_author
    if game_author != User.logged_in_as
      return false
    else
      return true
    end
  end

  def add_levels more
    if (more == "1")
      return true
    else
      return false
    end
  end

  def check_level_is_correct answer, answer2
    if(answer == answer2)
      return true
    else
      return false
    end
  end
end

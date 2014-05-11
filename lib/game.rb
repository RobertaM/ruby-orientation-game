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
  end

  def check_if_level_exists level
    if levels.include? level
    return true
    end
  end 

  def add_level level
    @levels.push(level)
    return true    
  end

  def add_team team 
    players.push[@team]
    return true
  end

  def participaiting_teams
    players 
  end
end

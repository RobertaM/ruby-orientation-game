
class Game
  attr_accessor :name, :author, :category, :real, :available, :complexity, :information, :start_time, :end_time, :players, :levels, :won

  def initialize
    @category = :real
    @levels = []
    @won = false
    @players = []
  end

  def categorised?
    @category == :real
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
  
  def valid? 
    if @author.nil?
      return false
    end
	
    if @name.nil?
      return false
    end
	
    if @category.nil?
      return false
    end
	
    return true
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

  def teams_participaiting
    if players.nil?
      return false
    else
      for i in (0..players.length - 1)
        puts players[i]
      end
      return true
    end
  end
end

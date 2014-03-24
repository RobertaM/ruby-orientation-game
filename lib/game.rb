
class Game
  attr_accessor :name, :author, :category, :real, :available, :complexity, :information, :start_time, :end_time

  def initialize
    @category = :real
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
    
    valid_time
    valid_end_time
	
    return true
  end
end

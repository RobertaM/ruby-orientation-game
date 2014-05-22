class Level
  attr_accessor :level_name, :level_time, :comment, :task,  :prompts, :bonus, :answer, :passed, :time

  def initialize
    @bonus = 0;
    @passed = false
    @prompts = []
  end  

  def passed?
  	return passed
  end

  def valid_time?
  	if time >=0
  	  return true
  	else
  	  return false
  	end
  end
end


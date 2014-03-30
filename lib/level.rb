class Level
  attr_accessor :level_name, :level_time, :comment, :task,  :prompts, :bonus, :answer, :passed

  def initialize
    @bonus = 0;
    @passed = false
    @prompts = []
  end  
    
  def valid_level_time

  end

  def valid_spent_time_in_level

  end

  def named?
    if level_name.nil?
      return false
    end
      return true
    end
  def commented?
    if comment.nil?
      return false
    else
      return true
    end
  end

  def task_is_defined 
    if task.nil?
      return false
    else
      return true
    end
  end
end


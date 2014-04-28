class Level
  attr_accessor :level_name, :level_time, :comment, :task,  :prompts, :bonus, :answer, :passed, :time

  def initialize
    @bonus = 0;
    @passed = false
    @prompts = []
  end  

  def named
    if level_name.nil?
      return false
    else
      return true
    end
  end

  def commented
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

  def prompts_is_defined
    if prompts.nil?
      return false
    else
      return true
    end
  end

  def answer_is_defined
    if answer.nil?
      return false
    else
      return true
    end
  end
end


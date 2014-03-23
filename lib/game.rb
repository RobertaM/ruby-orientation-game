
class Game
    attr_accessor :name, :author, :category, :real, :available, :complexity, :information, :start_time, :end_time

    def initialize
	#@compelxity = 0
	@category = :real
	#@start_time = Time.new() + (24*60*60)
    	#@end_time = Time.new() + (48*60*60)
    	#@available = false
    
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
        if @complexity == 0
	    return false
	end
    end
  
    def valid? 
	if @author.nil? and @name.nil?
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

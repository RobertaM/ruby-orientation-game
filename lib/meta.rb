class Meta
	@units=[]

	def self.load_data(units)
		@units = units ? units : []
	end

	def self.load_all()
	  return @units
	end

	def self.load_one(index)
	  if !@units[index-1].nil?
		return @units[index -1]
	  else 
	  	return false
	  end
	end


	def self.find_login_info(nickname, password)

	 @units.each do |unit|
	  	if(nickname == unit.nickname && password == unit.password)
          unit.login
          puts "found"
          return true
    	end
      end
       return false
	end

	def self.insert
		@units
	end

	def save_data
      	units = self.class.insert
      if !units.include?(self)
      	units.push(self)
  	  end
    end
end
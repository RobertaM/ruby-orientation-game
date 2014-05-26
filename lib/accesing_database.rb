class AccessingDatabase
	@units=[]

	def self.load_record(units)
		@units = units ? units : []
	end

	def self.load_all()
	  return @units
	end

	def self.load_one(index)
	  if !@units[index-1].nil?
	  	return @units[index -1]
	  end
	end

	def self.insert
		@units
	end

	def save_record
      units = self.class.insert
      if !units.include?(self)
      	units.push(self)
  	  end
    end
end
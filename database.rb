require_relative 'lib/user'
require_relative 'lib/game'
require_relative 'lib/team'
require_relative 'lib/level'
require_relative 'lib/forum_message'
require 'yaml'

class Database
  def self.change_format
    {
      users: User,
      games: Game,
      teams: Team,
      messages: ForumMessage
    }
  end

  def load_data(file)
    begin
      file.rewind
  	  data = YAML.load(file.read)
    rescue
      return false
  	end

    self.class.change_format.each do |key, value| 
      value.load_record(data[key])
    end
  end

  def save_data(file)
    data = {}
  	self.class.change_format.each do |key, value|
  	  data[key] = value.insert
    end
    file.write(data.to_yaml)
    return true
  end
end
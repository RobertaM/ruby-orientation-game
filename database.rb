require_relative 'lib/user'
require_relative 'lib/game'
require_relative 'lib/team'
require_relative 'lib/level'
require_relative 'lib/forum_message'
require 'yaml'

DATABASE = './database.yaml'

class Database
  def load_data

  	begin
  	  data = YAML.load(File.read(DATABASE))
  	end

    User.load_record(data[:users])
    Game.load_record(data[:games])
    Team.load_record(data[:teams])
    ForumMessage.load_record(data[:messages])
  end

  def save_data
  	File.open(DATABASE, 'w') do |database|
  	  data = {users: User.insert, games: Game.insert, teams: Team.insert, messages: ForumMessage.insert}
  	  database.write(data.to_yaml)
      puts "data is saved to database"
    end
  end
end
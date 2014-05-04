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

    User.load_data(data[:users])
    Game.load_data(data[:games])
    Team.load_data(data[:teams])
    Forum_message.load_data(data[:messages])
  end

  def save_data
  	File.open(DATABASE, 'w') do |database|
  	  data = {users: User.insert, games: Game.insert, teams: Team.insert, messages: Forum_message.insert}
  	  database.write(data.to_yaml)
      puts "wrote smthg"
    end
  end
end
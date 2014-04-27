require_relative 'lib/user'
require_relative 'lib/game'
require_relative 'lib/team'
require_relative 'lib/level'
require 'yaml'

DATABASE = './database.yaml'

class Database
  attr_accessor :users, :games, :teams
  
  def create
    @users = []
    @games = []
    @teams = []
  end

  def load_data
  	create

  	begin
  	  data = YAML.load(File.read(DATABASE))
  	end

  	@users = data[:users] if not data[:users].nil?
  	@games = data[:games] if not data[:games].nil?
  	@teams = data[:teams] if not data[:teams].nil?
  	return true
  end

  def save_data
  	File.open(DATABASE, 'w') do |database|
  	data = {users: @users, games: @games, teams: @teams}
  	database.write(data.to_yaml)
    end
  end
end
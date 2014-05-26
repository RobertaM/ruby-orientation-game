require_relative 'lib/team'
require_relative 'lib/game'
require_relative 'lib/user'
require_relative 'database'
require_relative 'menu'

DATABASE = './database.yaml'
database = Database.new
database.load_data(File.open(DATABASE))
    catch :quit do
	   @menu = Menu.new
       @menu.show
    end
  database.save_data(File.open(DATABASE, "w"))  


require_relative 'lib/team'
require_relative 'lib/game'
require_relative 'lib/user'
require_relative 'database'
require_relative 'menu'

class MainMenu
@menu = Menu.new
@menu.show
end

require_relative 'mainmenu'
require_relative 'database'
require_relative 'lib/game'
require_relative 'lib/team'
require_relative 'lib/user'
require_relative 'lib/level'

$database = Database.new
$database.load_data
class Menu 
  def show 

    puts "
   	  Options:
        1) Register
        2) Login
        3) Log out
        4) Create game
        5) Create team
        6) See games informaition
        7) See teams informaition
        8) See users informaition"        
   
	  case gets.strip
      when "1"
        register
        show
      when "2"
        login
        show
      when "3"
        logout
        show
      when "4"
        create_game
        show
      when "5"
        create_team
        show
      when "6"
        see_games_informaition
        show
      when "7"
        see_teams_information
        show
      when "8"
        see_users_informaition
        show
      when "9"
        add_level_to_game
        show
      when "10"
        levels_list
        show
      else
        puts "we dont have such option"
      end
  end

  def register 
    print "What is your decided nickname: "
    nickname = gets.chomp
    print "What is your full name: "
    name = gets.chomp
    print "What is your surname "
    surname = gets.chomp
    print "Where do you live: "
    address = gets.chomp 
    print "What is your phone number: "
    phone = gets.chomp
    print "What is your email address: "
    mail = gets.chomp 
    print "What is your decided password: "
    password = gets.chomp
    print "Please repeat your password: "
    check_password = gets.chomp
  
    user = User.new
    user.nickname = nickname
    user.name = name
    user.surname = surname
    user.address = address
    user.number = phone
    user.mail = mail
    user.password = password
    user.player_points = 0

    $database.users.push(user)

    $database.save_data
  end

  def login
    
    if (User.logged_in_as.nil?)
      print "Login information"
      print "Your username: "
      nickname = gets.chomp
      print "Your password: "
      password = gets.chomp

      $database.users.each do |user|
        if(nickname == user.nickname && password == user.password)
          user.login
          print "logged in as" + user.nickname
        end 
      end
    else
      print " u are already logged in"
    end
  end

  def logout 
    User.logged_in_as.logout
  end

  def create_team
    if (!User.logged_in_as.nil?)
      print "What is your decided team name "
      name = gets.chomp
    
      team = Team.new
    
      team.name = name
      team.number_of_games_played = 0
      team.players = []
      team.active_team = []
      team.passive_team = []
      team.points = 0
      team.captain = User.logged_in_as
      team.players.push(User.logged_in_as)
      
      $database.teams.push(team)

      $database.save_data
    else
      print "you have to login first"
    end
  end

  def create_game
    if (!User.logged_in_as.nil?)
      print "What is your decided game name: "
      name = gets.chomp
      print "Decided complexity 1-10 (1- easy, 10 hard)"
      complexity = gets.chomp
      print "infromaition for players "
      information = gets.chomp
      print "Decided start time "
      start_time = gets.chomp 
      print "Decided end time "
      end_time = gets.chomp

      game = Game.new
    
      game.name = name
      game.category = :real
      game.available = true
      game.complexity = complexity
      game.information = information
      game.players = []
      game.levels =[]
      game.won = nil
      game.author = User.logged_in_as

      $database.games.push(game)
      $database.save_data
    else
      print "you have to login first"
    end
  end

  def add_level_to_game()
    print "choose game"
    games_list
    game_index = gets.chomp.to_i
    if !$database.games.nil?
      game = $database.games[game_index - 1]
      while true do
        level = Level.new
        print "what is your decided level name"
        level.level_name = gets. chomp
        print "what is your decided level time"
        level.level_time = gets.chomp
        print "Coments for a level"
        level.comment = gets.chomp
        print "what is decided task for a level"
        level.task = gets.chomp
        print "what is level answer"
        level.answer = gets.chomp
        
        game.levels.push(level)
        $database.save_data    
        while true
          print "do you want to add more levels? 1-yes, 0- no"
          more = gets.strip
            if more == "0"
              return
            elsif more == "1"
              print "adding more levels"
              break;
            else
              print "no such option please try again"
            end
          end
      end
    else
      print "there is no created games"
    end
  end

  def games_list
    index = 0
    $database.games.each do |game|
      puts "#{index + 1}) #{game.name}"
      index = index + 1
    end
  end

  def levels_list
    games_list
    which_game = gets.chomp.to_i
    index = 0
    game = $database.games[which_game -1]
    game.levels.each do |level|
      puts "#{index + 1}) #{level.level_name}"
      index = index + 1
    end
  end
  
  def users_list
    index = 0
    $database.users.each do |user|
      puts "#{index + 1}) #{user.nickname}"
      index = index + 1
    end
  end

  def teams_list
    index = 0
    $database.teams.each do |team|
      puts "#{index + 1}) #{team.name}"
      index = index + 1
    end
  end

  def see_teams_information
    puts "choose team"
    teams_list
    puts "see information of team: "
    index = gets.chomp.to_i
    team = $database.teams[index - 1]
    puts "teams name #{team.name}"
    puts "teams members : " 
    team.players.each do |player| 
      print player.nickname 
    end
  end

  def see_users_informaition
    puts "choose user"
    users_list
    puts "see informaition of user"
    index = gets.chomp.to_i
    if !$database.users.nil?
      user = $database.users[index -1]
      puts "users nickname:  #{user.nickname}"
      puts "users name: #{user.name}"
      puts "users surname: #{user.surname}"
      puts "users address: #{user.address}"
      puts "users player points: #{user.player_points}"
      puts "users email: #{user.mail}"
      puts "users phone number: #{user.number}"
    else
      puts "there is no users"
    end
  end

  def see_games_informaition
    puts "choose game"
    games_list
    puts "see information of games"
    index = gets.chomp.to_i
    if !$database.games.nil?
      game = $database.games[index -1]
      puts "game name: #{game.name}"
      puts "game author is: #{game.author}"
      puts "game category is: #{game.category}"
      puts "is game available: #{game.available}"
      puts "game complexity: #{game.complexity}"
      puts "game informaition: #{game.information}"
    else
      puts "there is no game"
    end
  end
end

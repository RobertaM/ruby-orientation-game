require_relative 'mainmenu'
require_relative 'database'
require_relative 'lib/game'
require_relative 'lib/team'
require_relative 'lib/user'
require_relative 'lib/level'
require_relative 'lib/forum_message'

class Menu 

attr_accessor :database

  def initialize()
    @database = Database.new
    @database.load_data
  end

  def show 
  puts "
   	Options:
      1) Register
      2) Login
      3) Log out
      4) Create game
      5) Create team
      6) See games information
      7) See teams information
      8) See users information
      9) Add level to a game
      10) View levels in game
      11) Play game
      12) Add users to a team
      13) Show my team information
      14) Write forum message
      15) Read forum messages"        
    puts ""
    print "Choose number: "
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
        see_teams_information(0)
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
      when "11"
        play_game
        show
      when "12"
        add_members_to_a_team
        show
      when "13"
        see_teams_information(1)
        show
      when "14"
        write_forum_message
        show
      when "15"
        read_forum_messages
        show
      when "16"
        exit_program
      else
        puts "we dont have such option"
        show
      end
  end

  def get_input
    while true
      input = gets.chomp
      if input.empty?
        puts "Input is empty please, write something"
        return false
      else 
        return input
      end
    end
  end

  def register 
    
    if (!User.logged_in_as.nil?)
      puts "You are logged in, please log out so you could register"
      return
    end

    user = User.new

    print "What is your decided nickname: "
    nickname = get_input

    users = User.load_all
    users.each do |user|
      puts user.nickname
    if(nickname == user.nickname)
      puts "user already exists, try again"
      return
      end 
    end

    print "What is your full name: "
    name = get_input
    print "What is your surname "
    surname = get_input
    print "Where do you live: "
    address = get_input 
    print "What is your phone number: "
    phone = get_input
    while true
      print "What is your E-mail address: "
      mail = get_input
      if user.with_valid_email(mail)
        break
      else
        puts "E-mail is not valid please try again"
      end
    end 

    print "What is your decided password: "
    password = get_input
    print "Please repeat your password: "
    check_password = get_input
    
    while true
      if (password != check_password)
        puts "passwords dont match. Please try again"
        print "What is your decided password: "
        password = get_input
        print "Please repeat your password: "
        check_password = get_input
      else
        break
      end
    end

    user.nickname = nickname
    user.name = name
    user.surname = surname
    user.address = address
    user.number = phone
    user.mail = mail
    user.password = password
    user.player_points = 0
    puts user.name
    user.save_data

    puts "registration is succesful"
  end

  def login
    if (User.logged_in_as.nil?)
      puts "Login information"
      print "Your username: "
      nickname = get_input
      print "Your password: "
      password = get_input
      user = User.find_login_info(nickname, password)

      if (user)
        puts "logged in as: " + User.logged_in_as.nickname
      else
        puts "there is no such user"
      end 

    else
      puts "u are already logged in"
    end
  end

  def logout 
    User.logged_in_as.logout
  end

  def create_team
    if (!User.logged_in_as.nil?)
      if (!User.logged_in_as.team.nil?)
        puts "you already have a team"
        return
      end
      print "What is your decided team name "
      name = get_input
    
      team = Team.new
    
      team.name = name
      team.number_of_games_played = 0
      team.players = []
      team.active_team = []
      team.passive_team = []
      team.points = 0
      team.captain = User.logged_in_as
      team.players.push(User.logged_in_as)
      User.logged_in_as.team = team
      team.save_data
    else
      puts "you have to login first"
    end
  end

  def add_members_to_a_team
    if (!User.logged_in_as.nil?)
      user = User.logged_in_as
      
      if(!user.team.nil?)
        teams = Team.load_all
        teams.each do |db_team|
      
        if (user.team == db_team)
          puts "which users do you want to add to team" 
          list(User.load_all)
          index = gets.chomp.to_i
          if db_team.players.include? User.load_one(index)
            puts User.load_one(index).name
            puts "you are already a member of the team"
            break
          elsif User.load_all.length < index
            puts "there is no such member"     
          else
            user = User.load_one(index)
            puts user.nickname
            db_team.players.push(user)
            user.team = User.logged_in_as.team
            user.save_data
            puts "succesfully added player to a team"
            break                 
          end
        end
        end
      else
        puts "create a team first"
      end
    else 
      puts "login first"
    end
  end        

  def create_game
    if (!User.logged_in_as.nil?)
      print "What is your decided game name: "
      name = get_input
      print "Decided complexity 1-10 (1 - very easy, 10 - very hard)"
      complexity = get_input
      print "infromaition for players "
      information = get_input

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
      forum = []

      game.save_data
    else
      puts "you have to login first"
    end
  end

  def add_level_to_game()
    if (User.logged_in_as.nil?)
      puts "Please login first"
      return 
    end
    puts "choose game"
    list(Game.load_all)
    index = gets.chomp.to_i
    if Game.load_one(index).author != User.logged_in_as
      puts "you are not creator of a game, you cant modify a game"
      return
    else
      game = Game.load_one(index)
    end
    if Game.load_all.length > 0
      
      while true do
        level = Level.new
        print "what is your decided level name: "
        level.level_name = get_input
        print "Coments for a level: "
        level.comment = get_input
        print "what is decided task for a level: "
        level.task = get_input
        print "what is level answer: "
        level.answer = get_input
        
        game.levels.push(level)
        game.save_data

        while true
          print "do you want to add more levels? 1-yes, 0- no: "
          more = gets.strip
          if more == "0"
            return
          elsif more == "1"
            puts "adding more levels"
            break;
          else
            puts "no such option please try again"
          end
        end
      end
    else
      puts "there is no created games"
    end
  end

  def play_game 

    if (User.logged_in_as.nil?)
      puts "you have to be logged in to play a game"
      return
    end
    if (User.logged_in_as.team.nil?)
      puts "you have to be in team to play game"
      return
    end

    puts "in which game you want to paricipate"
    list(Game.load_all)
    which = gets.chomp.to_i
    index = 0
    game = Game.load_one(which)
    if (game.levels.nil?)
      puts "game dont have levels yet, you cant participate"
    end
    if(!game.won)
      game.levels.each do |level|
        puts "#{level.level_name}"
        puts "#{level.task}"
        while true
          print "Please insert level answer: "
          answer = gets.chomp
          if (answer == level.answer)
            puts "correct"
            index = index + 1
            break
          else
            puts "incorrect, please try again"
          end
        end
      end
      puts "congratulaitions you passed a game"
      game.won = true
    else
      puts "sorry game is already passed"
    end
  end

  def list units
    index = 0
    units.each do |unit|
      puts "#{index + 1}) #{unit.name}"
      index = index + 1
    end
  end

  def choose_one which
    units = which.load_all    
    list(units)
    
    puts "Choose one: "
    index = gets.chomp.to_i
    unit = which.load_one(index)
    
    return unit 
  end

  def not_logged_in
    if(!User.logged_in_as)
      puts "please login first"
      show
    end 
  end

  def see_teams_information which
    if not_logged_in
      return
    end

    if (which == 0)
      team = choose_one(Team)
    else 
      team = User.logged_in_as.team
    end

    if team == false
      puts "there is no such team"
    else
      puts "teams name #{team.name}"
      puts "teams members : " 
      list(team.players)
    end
  end

  def see_users_informaition
    user = choose_one(User) 
    if user == false 
      puts "no such user"
    else
      puts "users nickname:  #{user.nickname}"
      puts "users name: #{user.name}"
      puts "users surname: #{user.surname}"
      puts "users address: #{user.address}"
      puts "users player points: #{user.player_points}"
      puts "users email: #{user.mail}"
      puts "users phone number: #{user.number}"
    end
  end

  def see_games_informaition
    game = choose_one(Game) 
    if game == false
      puts "game does not exist"
    else
      puts "game name: #{game.name}"
      puts "game author is: #{game.author.name}"
      puts "game category is: #{game.category}"
      puts "is game available: #{game.available}"
      puts "game complexity: #{game.complexity}"
      puts "game informaition: #{game.information}"
    end
  end

  def write_forum_message
    not_logged_in
    puts "for which game you want to write forum mesage?"
    game = choose_one(Game)

    forum = Forum_message.new
    forum_msg = forum.send_message
    msg_author = User.logged_in_as.name
    message = []
    message.push(forum_msg)
    message.push(msg_author)
    game.forum.push(message)
    game.save_data
  end

  def read_forum_messages
    not_logged_in
    puts "Which game messages do you want to read"
    game = choose_one(Game)
    game.forum.each do |forum|
      puts "game comments: #{forum[0]}, by author: #{forum[1]}" 
    end
  end

  def exit_program
    @database.save_data
    exit!
  end

end

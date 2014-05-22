require 'spec_helper'
require 'game'
require 'user'
require 'team'
require 'level'

describe Team do 
  before :each do
    @user = User.new
    @team = Team.new
    @game = Game.new
    @level = Level.new
    @level.passed = false
    @level.answer = "ushallpass"
    @game.name = "New game"
    @game.players = []
    @team.level_answers = []
    @game.levels = []
    @game.won = false
    User.logged_in_as = @user
    @team.players = []
    @team.number_of_games_played = 0
  end

  it "expects that it can participate in a game" do
  	@game.players.push(@team)
	  expect(@team.able_to_participate_in_a(@game)).to be_true
  end

  it "expects that some random team do not participate in a game" do    
    expect(@team.able_to_participate_in_a(@game)).to be_false
  end

  it "can pass lavels with correct codes" do
    @team.level_answers.push("ushallpass")
    @team.level_answers.push("haris")
    @team.level_answers.push("Poteris")
    
    @game.add_level(@level)
    @level = Level.new
    @level.answer = "haris"
    @game.add_level(@level)
    
    @level = Level.new
    @level.answer = "Poteris"
    @game.add_level(@level)
    
    expect(@team.can_pass_levels(@game)).to be_true
  end

  it "can't pass levels with incorrect codes" do
    @team.level_answers.push("ushallpass")
    @team.level_answers.push("Haris")

    @game.add_level(@level)
    @level = Level.new
    @level.answer = "Kompas"
    @game.add_level(@level)

    expect(@team.can_pass_levels(@game)).to be_false
  end
  
  it "wins game if all levels are passed" do
    @level.passed = true
    @game.add_level(@level)
    
    @level = Level.new
    @level.passed = true
    @game.add_level(@level)
    
    @level = Level.new
    @level.passed = true
    @game.add_level(@level)

    expect(@team.can_win_game(@game)).to be_true
  end

  it "can't win a game if part of levels are not passed" do
    @level.passed = true
    @game.add_level(@level)
    
    @level = Level.new
    @level.passed = false
    @game.add_level(@level)
    
    expect(@team.can_win_game(@game)).to be_false
  end
  
  it "can get points if team gets winning points" do
    @team.players.push(User.logged_in_as)
    winner_points = 10
    expect(@team.can_get_points(winner_points)).to be_true
  end

  it "cant get points if did not won a game" do
    winner_points = 0
    expect(@team.can_get_points(winner_points)).to be_false
  end

  it "expect team to have points" do
    @team.points = 1
    expect(@team).to be_with_points
  end

  it "expect team cant have negative point value" do
    @team.points = -1
    expect(@team).to_not be_with_points
  end

  it "adds played game when its ended" do 
    expect(@team.count_games_played(@game)).to be_true
  end

  it "do not add games that are not played by a team" do
    @game = nil
    expect(@team.count_games_played(@gmae)).to be_false
  end

end
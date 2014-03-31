require 'spec_helper'
require 'game'
require 'user'
require 'team'
require 'level'

describe Team do 
  before :each do
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
   # @team.number_of_games_played = 0
  end

  it "expects that it can participate in a game" do
  	@game.players = [@team]
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
  
  it "can get points if game is won" do
    @game.won  = true
    expect(@team.can_get_points(@game)).to be_true
  end

  it "cant get points if game is not won" do
    expect(@team.can_get_points(@game)).to be_false
  end
end
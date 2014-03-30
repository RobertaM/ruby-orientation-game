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
    
    expect(@team.can_pass_levels(@game)).to _be_true
  end
end
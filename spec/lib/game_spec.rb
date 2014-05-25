require 'spec_helper'
require 'game'
require 'user'
require 'level'
require 'team'
describe Game do
  before :each do
    @user = User.new
    @team = Team.new
    @game = Game.new
    @game.name = "HITMEN"
    @game.complexity = 0
    @game.information = "LEts do this"
    @game.start_time = Time.now + (24*60*60)
    @game.end_time = Time.now + (48*60*60)
    @game.levels = []
  end	

  it "has a real game category by default" do
    expect(@game.category).to eq(:real) 
  end

  it "can have other type of category" do
    @game.category = :points
    expect(@game.category).to eq(:points)
  end
  
  it "start date and time hasin't passed" do
    expect(@game.valid_time).to be_true
  end
  
  describe "#valid_time" do
    it "returns false if start time already passed" do
      @game.start_time = Time.now - (24*60*60)
      expect(@game.valid_time).to be_false
    end
  end

  describe "#valid_end_time" do
    it "returns true if start time and time now is less then end time" do
      expect(@game.valid_end_time).to be_true
    end
  end

  describe "#valid_end_time" do 
    it "returns false if end time is less then time now" do
      @game.end_time = Time.now - (60*60*25)
      expect(@game.valid_end_time).to be_false
    end
  end

  describe "#valid_end_time" do
    it "returns false if end time is less then start time" do
      @game.start_time = Time.now - (60*60)
      expect(@game.valid_end_time).to be_false
    end
  end
  
  it "expect game to not be complex when complexity <=7" do 
    @game.complexity = 1
    expect(@game).to_not be_complex
  end

  it "expect game to not be complex when complexity >7" do
    @game.complexity = 7
    expect(@game).to be_complex
  end

  let(:level) do  #new
    @level = Level.new
    level.level_time = (60*60)
    level.task = "to do some stuff"
    level.answer = "ucanpass"
    level  
  end

  it "cheks if level exists" do   #new
    @game.levels.push(@level)
    expect(@game.check_if_level_exists(@level)).to be_true
  end

  it "returns false if level do not exists" do   #new
    expect(@game.check_if_level_exists(@level)).to be_false
  end

  it "adds level to a game" do
    @level = Level.new
    expect(@game.add_level(@level)).to be_true
  end

  it "returns false if level do no exist" do
    @level = nil
    expect(@game.add_level(@level)).to be_false
  end

  it "checks which teams do participate in a game" do
    @team = Team.new
    @team.name = "Hey"
    @game.players.push(@team)
    @team = Team.new
    @team.name = "Aloha"
    @game.players.push(@team)

    expect(@game.participaiting_teams).to include(@game.players[0.1])
  end


  it "is not categorised" do
    @game.category = nil
    expect(@game.categorised).to be_nil
  end

  it "is valid" do
    expect(@game).to_not be_nil
  end

  it "is not valid" do 
    @game = nil
    expect(@game).to be_nil
  end

  it "expects to be available" do
    @game.available = true
    expect(@game.valid).to be_true
  end

  it "gives points to game  winners" do
    @levels_length = 3
    @game.complexity = 1
    expect(@game.give_points_to_winner(@levels_length)).should be > 0
  end


  it "gives points to game  winners" do
    @levels_length = 0
    @game.complexity = 1
    expect(@game.give_points_to_winner(@levels_length)).should be == 0
  end

  it "returns true if user is creator of game" do
    expect(@game.creator_of_game(User.logged_in_as)).to be_true 
  end

  it "returns false if user is not creator of game" do
    @user2 = User.new
    expect(@game.creator_of_game(@user2)).to be_false 
  end

  it "returns true if user asks to add more levels" do
    expect(@game.add_levels("1")).to be_true
  end

  it "returns false if user do not ask to add more levels" do
    expect(@game.add_levels("0")).to be_false
  end

  it "returns true if users provided answer is equal to given answer in system" do
    expect(@game.check_level_is_correct("a", "a")).to be_true
  end 

  it "returns true if users provided answer is equal to given answer in system" do
    expect(@game.check_level_is_correct("a", "b")).to be_false
  end

  it "returns true if team was added succesfully" do 
    expect(@game.add_team(@team)).to be_true
  end   

  it "return false if team was not added succesfully" do
    @team = nil
    expect(@game.add_team(@team)).to be_false
  end

  it "expects to return participaiting teams" do
    expect(@game.participaiting_teams).to_not be_nil
  end 

  
end

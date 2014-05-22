require 'spec_helper'
require 'user'
require 'game'
require 'team'

describe User do
  before :each do
    @user = User.new
    @user.nickname = "thomas"
    @user.name = "tomas"
    User.logged_in_as = @user 
    @level = Level.new
  end

  it "expect user to have points" do
    @user.player_points = 0
    expect(@user).to be_with_player_points
  end
    
  it "expect player cant have negative point value" do
    @user.player_points = -1
    expect(@user).to_not be_with_player_points
  end

  it "has valid email address" do
    @user.mail = "email@gmail.com"	
    expect(@user.with_valid_email(@user.mail)).to be_true
  end
  
  describe "#with_valid_email?" do
    it "returns false if email is not valid" do
      @user.mail = "email.com"
      expect(@user.with_valid_email(@user.mail)).to_not be_true
    end
  end 
    
  let(:game) do
    game = Game.new
    game.author = @user
    game.name = "HITMEN"
    game.complexity = 1 
    game.information = "LEts do this"
    game.start_time = Time.now + (24*60*60)
    game.end_time = Time.now + (48*60*60)
    game.won = false
    game.levels.push(@level)
    game	
  end

  it "is an author of a game" do
    expect(@user.author_of(game)).to be_true
  end

  it "is not author of some random new game" do
    @game = Game.new  
    expect(@user.author_of(@game)).to be_false
  end


  let(:team) do  #new
    team = Team.new
    team.name = "The Team"
    team.number_of_games_played = 0
    team.players = []
    team.players.push(@user)
    team
  end

  it "should be captain" do #new
    team.captain = @user
    expect(@user.captain_of(team)).to be_true
  end

  it "should not be captain of another team" do #new
    expect(@user.captain_of(team)).to be_false
  end
end

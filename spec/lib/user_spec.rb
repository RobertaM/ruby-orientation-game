require 'spec_helper'
require 'user'
require 'game'
require 'team'

describe User do
  before :each do
    @user = User.new
    @user2 = User.new
    @game = Game.new
    @team = Team.new
    @team.players = []
    @team.points = 10
    @user.nickname = "thomas"
    @user.name = "tomas"
    User.logged_in_as = @user 
    @level = Level.new
    @team.players.push(@user)
    @team.players.push(@user2)
  end

  it "expects that attribute is not empty" do
    expect(@user.attribute_is_not_empty(@user.name)).to be_true
  end

  it "expects that attribute is not empty" do
    @user.name = nil
    expect(@user.attribute_is_not_empty(@user.name)).to be_false
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

  it "expects that user logs in " do 
    expect(@user.login).to be_true
  end

  it "can get points" do
    @team.players.push(@user)
    @team.players.push(@user2)
    @team.points = 20
    expect(@user.can_get_points(@team)).to be_true
  end

  it "cant get points" do
    @team.players.push(@user)
    @team.players.push(@user2)
    @team.points = 0
    expect(@user.can_get_points(@team)).to be_false
  end

  it "checks if user exists" do
    @user.nickname = "a"
    expect(User.check_if_exists(@user.nickname)).to be_true
  end
  
  it "checks if user exists" do 
    @user.nickname = "t"
    expect(User.check_if_exists(@user.nickname)).to be_false
  end

  it "expect password matches" do
    password = "labas"
    password_check = "labas"
    expect(@user.password_match(password, password_check)).to be_true
  end

  it "expect password do not match" do
    password = "labas"
    password_check = "aloha"
    expect(@user.password_match(password, password_check)).to be_false
  end

  it "expects to find login information" do
    expect(User.find_login_info("a", "a")).to be_true
  end

  it "expects to find login information" do
    expect(User.find_login_info("a", "b")).to be_false
  end
end

require 'spec_helper'
require 'game'
require 'user'
require 'team'
require 'level'

describe System do 
  before :each do
    @system = System.new
    @user = User.new
    @user.name = "Rufus"
    @team = Team.new
    @team.name = "Transporteris"
    @game = Game.new
    @game.name = "HitmEN"
end

  it "adds user to users list" do
    expect(@system.adds_to_users_list(@user)).to be_true
  end
  
  it "adds team to teams list" do
    expect(@system.adds_to_teams_list(@team)).to be_true
  end

  it "adds game to games list" do
    expect(@system.adds_to_games_list(@game)).to be_true
  end

  it "delete user from users list" do
  	expect(@system.delete_user_from_list(@user)).to be_true
  end

  it "delete team from teams list" do
    expect(@system.delete_team_from_list(@team)).to be_true
  end

  it "delete game from games list" do
  	expect(@system.delete_game_from_list(@game)).to be_true
  end
end
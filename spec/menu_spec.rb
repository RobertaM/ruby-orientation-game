require_relative 'spec_helper'
require 'user'
require 'team'
require_relative '../menu'

describe Menu do  
  before :each do
    @menu = Menu.new
    @user = User.new
    @team = Team.new
    User.logged_in_as = @user
  end

    it "should return text if function works properly" do
      allow(Kernel).to receive(:gets).and_return("it works")
    end

    it "should not let register if user is logged in" do
      expect(@menu.register).to be_false
    end

    it "should not let login if you already are logged in" do
      expect(@menu.login).to be_false
    end

    it "should let user to log out" do     
      expect(@menu.logout).to be_true
    end

    it "should not let user to create team if he is not logged in" do
      User.logged_in_as = nil
      expect(@menu.create_team).to be_false
   	end

   	it "should not let create team if user already have one" do
   	  User.logged_in_as.team = @team
   	  expect(@menu.create_team).to be_false
   	end

   	it "should not let create a game if user is not logged in" do
   	  User.logged_in_as = nil
   	  expect(@menu.create_game).to be_false
   	end

   	it "should not let add levels to a game if user is not logged in" do
   	  User.logged_in_as = nil
   	  expect(@menu.add_level_to_game).to be_false
   	end

   	it "should not let user to play game if he is not logged in" do
      User.logged_in_as = nil
      expect(@menu.play_game).to be_false
   	end

   	it "should not let play game if does not have team" do
   	  User.logged_in_as.team = nil
   	  expect(@menu.play_game).to be_false
   	end

end


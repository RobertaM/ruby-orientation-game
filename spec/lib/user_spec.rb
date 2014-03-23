require 'spec_helper'
require 'user'
require 'game'

describe User do
    before :each do
    	@user = User.new
	@user.nickname = "thomas"
	@user.name = "tomas" 
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
	@user.mail = "tomas@gmail.com"	
	expect(@user).to be_with_valid_email
    end
    
    let(:game) do
	game = Game.new
	game.author = @user
	game.name = "HITMEN"
	game.complexity = 0 
	game.information = "LEts do this"
	game.start_time = Time.now + (24*60*60)
	game.end_time = Time.now + (48*60*60)
	game	
    end



    it "user is an author of a game" do
	expect(@user.is_author_of(game)).to be_true
    end
end
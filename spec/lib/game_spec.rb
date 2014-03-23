require 'spec_helper'
require 'game'
require 'user'
describe Game do
  before :each do
    @user = User.new
    @game = Game.new
    @game.name = "HITMEN"
    @game.complexity = 0
    @game.information = "LEts do this"
    @game.start_time = Time.now + (24*60*60)
    @game.end_time = Time.now + (48*60*60)
  end	

  it "has a real game category by default" do
    expect(@game.category).to eq(:real) 
  end

  it "start date and time hasin't passed" do
    expect(@game.valid_time).to be_true
  end

  it "returns false if start time already passed" do
    @game.start_time = Time.now - (24*60*60)
    expect(@game.valid_time).to be_false
  end

   
  it "returns true if start time and time now is less then end time" do
    expect(@game.valid_end_time).to be_true
  end
   
  it "returns false if end time is less then time now" do
    @game.end_time = Time.now - (60*60*25)
    expect(@game.valid_end_time).to be_false
  end

  it "returns false if end time is less then start time" do
    @game.start_time = Time.now - (60*60)
    expect(@game.valid_end_time).to be_false
  end

  it "expect game to not be complex" do 
    @game.complexity = 1
    expect(@game).to_not be_complex
  end
	
  it "is a valid game" do
    @game.author = @user
    expect(@game).to be_valid
  end

  it "returns false if game category is dont exist" do
    @game.category = nil
    expect(@game).to_not be_valid
  end
   
  it "returns false if game author is nil" do
    @game.author = nil
    expect(@game).to_not be_valid
  end

  it "returns false if game name is nil" do
    @game.name = nil
    expect(@game).to_not be_valid
  end    
   
  it "returns false if start time already passed" do
    @game.start_time = Time.now - (24*60*60)
    expect(@game).to_not be_valid
  end

  it "returns false if end time is less start time" do
    @game.start_time = Time.now - (60*60)
    expect(@game).to_not be_valid
  end

  it "returns false if end time is less then start time" do
    @game.start_time = Time.now - (60*60)
    expect(@game).to_not be_valid
  end   
end

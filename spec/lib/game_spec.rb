 require 'spec_helper'
require 'game'

describe Game do
    before :each do
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
	@game.start_time = Time.now + (60*60)
	expect(@game.valid_time).to be_true
   end
   
   it "end date and time hasin't passed and more then start date and time " do
	@game.start_time = Time.now + (60*60)
	@game.end_time = Time.now + (60*60*25)
	expect(@game.valid_end_time).to be_true
   end
   
   
   it "expect game to not be complex" do 
	@game.complexity = 1
	expect(@game).to_not be_complex
   end

   let(:game) do
        @game = Game.new
        @game.name = "HITMEN"
        @game.complexity = 0
        @game.information = "LEts do this"
        @game.start_time = Time.new() + (24*60*60)
        @game.end_time = Time.new() + (48*60*60)
        @game
    end
	
    it "is a valid game" do
	expect(@game).to be_valid
    end

    

end

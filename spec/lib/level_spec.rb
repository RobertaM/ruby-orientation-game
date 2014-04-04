require 'spec_helper'
require 'level'

describe Team do 
  before :each do  
    @level = Level.new
    @level.level_name = 'first'
    @level.time = 60*60
    @level.task = "decode"
    @level.prompts = ["check source", "10101", "54.111 25.222"]
    @level.passed = false
    @level.answer = "ushallpass"
    @level.commented = "be careful"

  it "level is named" do
	expect(@level.named).to be_true
  end

  it "level is commented" do
  	expect(@level.commented).to be_true
  do

end
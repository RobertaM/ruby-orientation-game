require 'spec_helper'
require 'level'

describe Level do 
  before :each do  
    @level = Level.new
    @level.level_name = 'first'
    @level.time = 60*60
    @level.task = "decode"
    @level.prompts = ["check source", "10101", "54.111 25.222"]
    @level.passed = false
    @level.answer = "ushallpass"
    @level.comment = "be careful"
  end

  it "is named" do
	  expect(@level.named).to be_true
  end
  
  it "returns false is there is no level name" do
    @level.level_name = nil
    expect(@level.named).to_not be_true
  end

  it "is commented" do
  	expect(@level.commented).to be_true
  end

  it "returns false if there is no comments for a level" do
    @level.comment = nil
    expect(@level.commented).to be_false
  end  

  it "task is defined" do
    expect(@level.task_is_defined).to be_true
  end

  it "return false if task is not defined" do
    @level.task = nil
    expect(@level.task_is_defined).to_not be_true
  end

  it "prompts are defined" do
    expect(@level.prompts_is_defined).to be_true
  end

  it "returns false if prompts are not defined" do
    @level.prompts = nil
    expect(@level.prompts_is_defined).to_not be_true
  end

  it "has an answer" do
    @level.answer = "shall pass"
    expect(@level.answer_is_defined).to be_true
  end 

  it "has an answer" do
    @level.answer = nil
    expect(@level.answer_is_defined).to_not be_true
  end 
end
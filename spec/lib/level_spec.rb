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

  
  it "by default is not passed" do
    expect(@level).to_not be_passed
  end

  it "can pass level" do
    @level.passed = true
    expect(@level).to be_passed
  end

  it "expects time to be valid" do
    expect(@level).to be_valid_time
  end

  it "expects time cant be negative" do
    @level.time = -1
    expect(@level).to_not be_valid_time
  end

  
end
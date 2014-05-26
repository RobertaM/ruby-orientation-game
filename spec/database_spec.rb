require "spec_helper"
require 'game'
require 'team'
require 'level'
require 'user'
require 'forum_message'
require_relative '../database'


describe Database do
  before :each do
  	@database = Database.new
  	@user = User.new
    User.load_all
  end
  subject(:database) { Database.new }
    let(:test) { File.read('spec/test/database.yaml') }

    it "expects to have at least one record" do
    	expect(Database.change_format).to have_at_least(1).item
	end

	it "expects to return false if file do not exist" do
		expect(@database.load_data('spec/test/data.yaml')).to be_false
    end

    let(:string_io) {StringIO.new(test)}

    it "can load from file" do
      expect(@database.load_data(string_io)).to be_true
    end


    it "can save data to database" do
      @user.name = "Thom"
      @user.surname = "Phil"
      @user.nickname = "nickname"
      @user.password = "password"
      @user.save_record
      @user
   
     expect(@database.save_data(File.open('spec/test/database.yaml', "w"))).to be_true
    end

    it "can load one user" do
      expect(User.load_one(2)).to_not be_false
    end

end
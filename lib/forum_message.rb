require_relative 'accesing_database'
class ForumMessage < AccessingDatabase
  attr_accessor  :message

  def initialize message
  	@message = message
  end
end

require_relative 'meta'
class Forum_message < Meta
  attr_accessor  :message
  
  def send_message
    puts "Write your message: "
    message = gets.chomp
    if !message.nil?
      return message
  	else
  	  print "no message"
  	  return false
  	end
  end
end

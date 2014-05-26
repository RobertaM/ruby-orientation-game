RSpec::Matchers.define :get_points do |won_points|
  match do |team|
	  team.get_points? won_points
  end

  failure_message_for_should do |team|
  	"expected team #{team.name} to get points"
  end

  failure_message_for_should_not do |team|
  	"expected team #{team.name} to not get points"
  end

  description do
  	"team #{team.name} got #{team.points}"
  end
end

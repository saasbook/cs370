FactoryBot.define do
	begin 
		factory :tutor
		factory :request

		factory :meeting do
			tutor
			request
		end
	rescue FactoryBot::DuplicateDefinitionError => msg 
		puts msg
 	end	
end
FactoryGirl.define do
	begin 
		factory :tutor do 
			type_of_tutor "CSM"
			grade_level 'SENIOR'
			first_name 'ALVIN'
			last_name 'NGUYEN'
		end
	rescue FactoryGirl::DuplicateDefinitionError => msg 
		puts msg
 	end	
 	begin 
		factory :request
	rescue FactoryGirl::DuplicateDefinitionError => msg 
		puts msg
 	end

		factory :meeting do
			tutor
			request
		end	
end
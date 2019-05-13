class BerkeleyClass < ApplicationRecord

	def true_classes
		@preferred_classes = []
		self.attributes.each_pair do |name, value|
	      	if value == true
	        	@preferred_classes.push(name)
	      	end
      	end
      	@preferred_classes
	end

	def self.all_classes
		@classes = []
		BerkeleyClass.column_names.each do |colunm_name|
			@classes.push(colunm_name) if colunm_name != "id"
		end
		@classes
	end

end

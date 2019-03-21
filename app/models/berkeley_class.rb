class BerkeleyClass < ApplicationRecord
	def true_classes
		@preferred_classes = []
		self.attributes.each_pair do |name, value|
	      	if value
	        	@preferred_classes.push(name)
	      	end
      	end
      	@preferred_classes
	end

	def all_classes
		@preferred_classes = []
		self.attributes.each_pair do |name, value|
	        @preferred_classes.push(name)
      	end
      	@preferred_classes

	end

end

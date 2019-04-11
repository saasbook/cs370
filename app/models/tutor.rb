class Tutor < ApplicationRecord
	has_one :berkeley_class
	validates :type_of_tutor, presence: true
	validates :grade_level, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
end

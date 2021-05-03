class Admin < ApplicationRecord
  has_secure_password
  # The Admin table should only contain 1 row! This row holds all global variables that are configurable by an admin
  class<<self
    def master_admin_index
      # All admins access/modify the same row
      return 1
    end

    def semester_possibilities
      # This should have to change much unless we move to the quater system
      # Can not be all caps else _formatted functions wont work
      return %w(Spring Fall Summer)
    end

    def get_course_list
      self.find_by_id(master_admin_index).course_list
    end

    def tutor_types
      self.find_by_id(master_admin_index).tutor_types
    end

    def priority_list_contains? tutee_sid
      self.find(master_admin_index).priority_list.include? tutee_sid
    end

    def signups_allowed
      self.find_by_id(master_admin_index).signups_allowed
    end

    def current_semester
      self.find_by_id(master_admin_index).current_semester
    end

    def current_semester_formatted
      self.current_semester.gsub(/(?<=[a-z])(?=[0-9])/, ' ')
    end

    def statistics_semester
      # Adds space between lower case and numbers
      self.find(master_admin_index).statistics_semester
    end

    def statistics_semester_formatted
      # Adds space between lower case and numbers
      self.statistics_semester.gsub(/(?<=[a-z])(?=[0-9])/, ' ')
    end

    def validate_year(year)
      year.match(/^\d{4}$/)
    end


    # These are used by all cucumber tests and db/seeds.rb
    def general_seed_password
      '111111'
    end
  end
end

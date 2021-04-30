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

    def signups_allowed
      return self.find_by_id(master_admin_index).signups_allowed
    end

    def toggle_signups
      self.find_by_id(master_admin_index).update(:signups_allowed => !self.signups_allowed)
    end

    def current_semester
      # do some error handing for test cases
      @admin = self.find_by_id(master_admin_index)
      if @admin
        return @admin.current_semester
      elsif Course.first
        # return first semester for testing or just in case admin hasnt been created
        return Course.first.semester
      else
        # return nothing if semesters havent been seeded/aren't important
        return nil
      end
    end
    def current_semester_formatted
      return self.current_semester.gsub(/(?<=[a-z])(?=[0-9])/, ' ')
    end
    def statistics_semester
      # Adds space between lower case and numbers
      return self.find(master_admin_index).statistics_semester
    end
    def statistics_semester_formatted
      # Adds space between lower case and numbers
      return self.statistics_semester.gsub(/(?<=[a-z])(?=[0-9])/, ' ')
    end
    def validate_year(year)
      return year.match(/^\d{4}$/)
    end
  end
end

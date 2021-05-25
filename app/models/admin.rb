class Admin < ApplicationRecord
  has_secure_password
  # The Admin table should only contain 1 row! This row holds all global variables that are configurable by an admin
  class<<self
    def master_admin_index
      # All admins access/modify the same row
      return 1
    end

    def course_list
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

    # These are used by all cucumber tests and db/seeds.rb
    def general_seed_password
      '111111'
    end
  end
end

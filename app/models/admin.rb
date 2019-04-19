class Admin < ApplicationRecord
  has_secure_password
  class<<self
    def master_admin_index
      return 1
    end
  end
end

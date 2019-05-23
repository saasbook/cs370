class Tutee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :validatable, :recoverable, :rememberable, stretches: 12
  has_many :requests
  has_many :courses, through: :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests
  has_many :tutors, through: :requests

  validates :birthdate, presence: {message: "Birthdate cannot be blank"}, format: {with: /\d{4}-\d{2}-\d{2}/, message: "Invalid Birthdate format"}
  validates :sid, presence: true, numericality: { message: "%{attribute} must be a number" }, format: {with: /\d{5,12}/, message: "Must be at 6-12 digits"}
  validates :first_name, presence: true, format: {with: /\A[a-zA-Z\u00C0-\u017F\s.'-]*\z/, message: "First name cannot contain numbers or specail character"}
  validates :last_name, presence: {message: "Last name cannot be blank"}, format: {with: /\A[a-zA-Z\u00C0-\u017F\s.'-]*\z/, message: "Last name cannot contain numbers or specail character"}
  validates :gender, presence: {message: "Gender cannot be blank"}, inclusion: { in: %w(female male nonbinary prefer\ not\ to\ say), message: "Must be valid selection"}
  validates :ethnicity, presence: {message: "Ethnicity cannot be blank"}, inclusion: { in: %w(Asian Black/African Caucasian Hispanic/Latinx Native\ American Pacific\ Islander mixed other prefer\ not\ to\ say), message: "Must be valid selection"}
  validates :dsp, presence: {message: "DSP cannot be blank"}, inclusion: { in: %w(No Yes), message: "Must be valid selection"}
  validates :transfer,presence: {message: "Transfer cannot be blank"}, inclusion: { in: %w(No Yes), message: "Must be valid selection"}
  validates :major,presence: {message: "Major cannot be empty"}, inclusion: { in: %w(EECS CS other), message: "Must be valid selection"}
  validates :pronoun, presence: {message: "Pronoun cannot be empty"}, inclusion: { in: %w(he/his she/her they/their other), message: "Must be valid selection"}
  validates :year, presence: {message: "Year cannot be left empty"}, inclusion: { in: %w(1\ year 2\ years 3\ years 4\ years 5+\ years), message: "Must be valid selection"}
  validates :privilege, presence: {message: "Privilege cannot be left empty"}, inclusion: { in: %w(No cs61a cs61b cs61c cs70), message: "Must contain invalid inputs"}
  validates :email, presence: {message: "Email cannot be blank"}, format: {with: /\A[a-z0-9\+\-_\.]+@berkeley.edu/i, message: "Must be a berkeley email"}
  validate :validate_birth

  private
  def validate_birth
    if birthdate.present? && birthdate > Time.now
      errors.add(:birthdate, 'Your birthdate cannot be in the future')
    end
  end

  # class functions
  class<<self
    def get_cs61a_privileged_students
      return self.where(:privilege => "cs61a")
    end
    def get_current_cs61a_sids_formatted
      return format_sids(self.get_cs61a_privileged_students)
    end

    def get_cs61b_privileged_students
      return self.where(:privilege => "cs61b")
    end
    def get_current_cs61b_sids_formatted
      return format_sids(self.get_cs61b_privileged_students)
    end

    def get_cs61c_privileged_students
      return self.where(:privilege => "cs61c")
    end
    def get_current_cs61c_sids_formatted
      return format_sids(self.get_cs61c_privileged_students)
    end

    def get_cs70_privileged_students
      return self.where(:privilege => "cs70")
    end
    def get_current_cs70_sids_formatted
      return format_sids(self.get_cs70_privileged_students)
    end

    def format_sids(some_search_function)
      formated_string = ""
      some_search_function.pluck(:sid).each do |sid|
        formated_string += (sid.to_s) + "\r\n"
      end
      return formated_string[0..-2] # removes the final \n from the string
    end

    def update_cs61a_privileges(sids)
      return update_privileges(sids, self.get_cs61a_privileged_students, "cs61a")
    end
    def update_cs61b_privileges(sids)
      return update_privileges(sids, self.get_cs61b_privileged_students, "cs61b")
    end
    def update_cs61c_privileges(sids)
      return update_privileges(sids, self.get_cs61c_privileged_students, "cs61c")
    end
    def update_cs70_privileges(sids)
      return update_privileges(sids, self.get_cs70_privileged_students, "cs70")
    end
    def update_privileges(sids, some_search_function, privilege_to_change_to)
      sids = sids.to_s.split("\r\n").map { |c| c.gsub(/\s+/, "") }#.map{ |sid| {:sid => sid}} #split, remove spaces
      #should now be a array of sids

      # update all students currently with that privilege to not have that privilege anymore
      some_search_function.update_all(:privilege => "No")


      # find students with a given sid and update to have that privilege, do nothing if sid doesnt correspond to a tutee account.
      sids.each do |sid|
        @tutee = self.find_by_sid(sid).try(:update_attributes, {:privilege => privilege_to_change_to})
      end

      # Code below currently not needed because if a student doesnt have account yet then sids will be larger than the current sids with that privilege
      # verify that the number of active courses is now the same. (uniq is to ignore duplicates)
      # return some_search_function.count == sids.uniq.count
    end
  end
end

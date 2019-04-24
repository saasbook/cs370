class Tutee < ApplicationRecord
  has_many :requests
  has_many :tutors, through: :requests
  validates :birthdate, presence: {message: "Birthdate cannot be blank"}, format: {with: /\d{4}-\d{2}-\d{2}/, message: "Invalid Birthdate format"}
  validates :sid, presence: true, numericality: { message: "%{attribute} must be a number" }, format: {with: /\d{5,12}/, message: "Must be at 6-12 digits"}
  validates :first_name, presence: true, format: {with: /\A[a-zA-Z'-]*\z/, message: "First name cannot contain numbers or specail character"}
  validates :last_name, presence: {message: "Last name cannot be blank"}, format: {with: /\A[a-zA-Z'-]*\z/, message: "Last name cannot contain numbers or specail character"}
  validates :gender, presence: {message: "Gender cannot be blank"}, inclusion: { in: %w(female male nonbinary prefer\ not\ to\ say), message: "Must be valid selection"}
  validates :ethnicity, presence: {message: "Ethnicity cannot be blank"}, inclusion: { in: %w(Asian Black/African Caucasian Hispanic/Latinx Native\ American Pacific\ Islander mixed other prefer\ not\ to\ say), message: "Must be valid selection"}
  validates :dsp, presence: {message: "DSP cannot be blank"}, inclusion: { in: %w(No Yes), message: "Must be valid selection"}
  validates :transfer,presence: {message: "Transfer cannot be blank"}, inclusion: { in: %w(No Yes), message: "Must be valid selection"}
  validates :major,presence: {message: "Major cannot be empty"}, inclusion: { in: %w(EECS CS other), message: "Must be valid selection"}
  validates :pronoun, presence: {message: "Pronoun cannot be empty"}, inclusion: { in: %w(he/his she/her they/their other), message: "Must be valid selection"}
  validates :year, presence: {message: "Year cannot be left empty"}, inclusion: { in: %w(1\ year 2\ years 3\ years 4\ years 5+\ years), message: "Must be valid selection"}
  validates :privilege, presence: {message: "Privilege cannot be left empty"}, inclusion: { in: %w(No cs61a cs61b cs61c cs70), message: "Must contain invalid inputs"}
  validates :email, presence: {message: "Email cannot be blank"}, uniqueness: {message: "Account for email already exits"}, format: {with: /\A[a-z0-9\+\-_\.]+@berkeley.edu/i, message: "Must be a berkeley email"}
  validate :validate_birth

  private
  def validate_birth
    if birthdate.present? && birthdate > Time.now
      errors.add(:birthdate, 'Your birthdate cannot be in the future')
    end
  end


end
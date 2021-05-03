class Tutee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :validatable, :recoverable, :rememberable, stretches: 12
  has_many :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests
  has_many :tutors, through: :requests

  validates :sid, presence: true, numericality: { message: "%{attribute} must be a number" }, format: {with: /\d{5,12}/, message: "Must be at 6-12 digits"}
  validates :first_name, presence: true, format: {with: /\A[a-zA-Z\u00C0-\u017F\s.'-]*\z/, message: "First name cannot contain numbers or specail character"}
  validates :last_name, presence: {message: "Last name cannot be blank"}, format: {with: /\A[a-zA-Z\u00C0-\u017F\s.'-]*\z/, message: "Last name cannot contain numbers or special character"}
  validates :gender, presence: {message: "Gender cannot be blank"}
  validates :ethnicity, presence: {message: "Ethnicity cannot be blank"}
  validates :dsp, inclusion: {in:[true,false], message: "DSP cannot be blank"}
  validates :transfer,inclusion: {in:[true,false], message: "Transfer cannot be blank"}
  validates :major,presence: {message: "Major cannot be empty"}
  validates :pronoun, presence: {message: "Pronoun cannot be empty"}
  validates :term, presence: {message: "Term cannot be left empty"}
  validates :email, presence: {message: "Email cannot be blank"}, format: {with: /\A[a-z0-9\+\-_\.]+@berkeley.edu/i, message: "Must be a berkeley email"}

  def self.to_csv
    attributes = self.attribute_names

      CSV.generate(headers: true) do |csv|
        csv << attributes.first(14)

        all.each do |tutee|
          csv << tutee.attributes.values.first(14)
        end
      end
  end
end

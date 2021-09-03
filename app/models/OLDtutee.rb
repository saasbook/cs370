class Tutee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :validatable, :recoverable, :rememberable, stretches: 12
  has_many :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests
  has_many :tutors, through: :requests

  

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

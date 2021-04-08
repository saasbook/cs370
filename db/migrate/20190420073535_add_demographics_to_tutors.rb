class AddDemographicsToTutors < ActiveRecord::Migration[5.2]
  def change
    add_column :tutors, :birthday, :date
    add_column :tutors, :gender, :string
    add_column :tutors, :sid, :bigint
    add_column :tutors, :major, :string
    add_column :tutors, :dsp?, :boolean
    add_column :tutors, :transfer?, :boolean
  end
end

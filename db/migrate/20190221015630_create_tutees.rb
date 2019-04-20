class CreateTutees < ActiveRecord::Migration[5.2]
  def change
    create_table :tutees do |t|
      t.integer :sid, :limit => 8
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :email
      t.string :privilege, :default => "No"
      t.string :gender, :default => "prefer not to say"
      t.string :pronoun, :default => "other"
      t.string :ethnicity, :default => "prefer not to say"
      t.string :major, :default => "CS"
      t.string :dsp, :default => "No"
      t.string :transfer, :default => "No"
      t.string :year, :default => "1 year"
      t.json :meta_values
      t.timestamps
    end
  end
end

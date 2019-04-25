class CreateTutees < ActiveRecord::Migration[5.2]
  def change
    create_table :tutees do |t|
      t.integer :sid, :limit => 8
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :email
      t.string :privilege
      t.string :gender
      t.string :pronoun
      t.string :ethnicity
      t.string :major
      t.string :dsp
      t.string :transfer
      t.string :year
      t.json :meta_values
      t.timestamps
    end
  end
end

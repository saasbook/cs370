class CreateTutees < ActiveRecord::Migration[5.2]
  def change
    create_table :tutees do |t|
      t.integer :sid, :limit => 8
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.date :birthdate, :null => false
      t.string :email, :null => false
      t.string :privilege, :null => false
      t.string :gender, :null => false
      t.string :pronoun, :null => false
      t.string :ethnicity, :null => false
      t.string :major, :null => false
      t.string :dsp, :null => false
      t.string :transfer, :null => false
      t.string :year, :null => false
      t.json :meta_values
      t.timestamps
    end
  end
end

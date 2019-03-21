class CreateTutees < ActiveRecord::Migration[5.2]
  def change
    create_table :tutees do |t|
      t.integer :sid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :privilege
      t.json :meta_values
      t.timestamps
    end
  end
end

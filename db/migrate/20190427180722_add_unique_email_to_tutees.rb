class AddUniqueEmailToTutees < ActiveRecord::Migration[5.2]
  def change
    add_index :tutees, :email, :unique => true
  end
end

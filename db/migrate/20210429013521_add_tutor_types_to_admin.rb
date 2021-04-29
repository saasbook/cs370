class AddTutorTypesToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :tutor_types, :text, :default=> "this is default text"
  end
end

class AddLocationsToMeetings < ActiveRecord::Migration[5.2]
  def change
  	add_column :meetings, :locations, :string, array: true, default: []
  end
end

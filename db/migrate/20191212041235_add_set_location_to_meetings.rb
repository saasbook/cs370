class AddSetLocationToMeetings < ActiveRecord::Migration[5.2]
  def change
  	add_column :meetings, :set_location, :string
  end
end

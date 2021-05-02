class RemoveArraysFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :locations, :string
    remove_column :meetings, :times, :datetime
  end
end

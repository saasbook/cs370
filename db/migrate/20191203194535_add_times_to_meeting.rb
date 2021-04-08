class AddTimesToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :times, :datetime, array: true, default: []
  end
end

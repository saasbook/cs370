class AddIsScheduledToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :is_scheduled, :boolean, default: false
  end
end

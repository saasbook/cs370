class AddSettimeToMeeting < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :setTime, :datetime, default: nil
  end
end

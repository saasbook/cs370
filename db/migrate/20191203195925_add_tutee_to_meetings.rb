class AddTuteeToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_reference :meetings, :tutee, foreign_key: true
  end
end

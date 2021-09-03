class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :request, index: true, foreign_key: true
      t.datetime :set_time, default: nil
      t.string :set_location
      t.boolean :is_scheduled, default: false
      t.boolean :is_done, default: false
      t.json :meta_values
      t.timestamps
    end
    rename_column :meetings, :user_id, :tutor_id
  end
end

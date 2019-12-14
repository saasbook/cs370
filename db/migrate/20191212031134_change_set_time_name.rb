class ChangeSetTimeName < ActiveRecord::Migration[5.2]
  def change
      rename_column :meetings, :setTime, :set_time
  end
end

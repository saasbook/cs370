class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :tutor, foreign_key: true
      t.references :request, foreign_key: true
      t.references :evaluation, foreign_key: true
      t.json :meta_values

      t.timestamps
    end
  end
end

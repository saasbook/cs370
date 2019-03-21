class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :tutee, foreign_key: true
      t.references :course, foreign_key: true
      t.string :subject
      t.json :meta_values
      t.timestamps
    end
  end
end

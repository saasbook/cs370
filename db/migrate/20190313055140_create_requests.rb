class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :request
      t.references :tutee, foreign_key: true
      t.references :class, foreign_key: true
      t.string :subject
      t.json :meta_values
      t.timestamps
    end
  end
end

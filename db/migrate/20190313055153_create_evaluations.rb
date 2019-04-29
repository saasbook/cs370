class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.boolean :took_place
      t.string :topics
      t.float :hours, :precision => 3, :scale => 2
      t.text :positive
      t.text :best
      t.text :feedback
      t.integer :knowledgeable, :limit => 1
      t.integer :helpful, :limit => 1
      t.integer :clarity, :limit => 1
      t.integer :pacing, :limit => 1
      t.text :final_comments
      t.string :status, :default => "Pending"
      t.timestamps
    end
  end
end

class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.string :topics
      t.integer :hours
      t.text :positive
      t.text :best
      t.text :feedback
      t.integer :knowledgeable
      t.integer :helpful
      t.integer :clarity
      t.integer :pacing
      t.text :final_comments
      t.timestamps
    end
  end
end

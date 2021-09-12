class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.belongs_to :meeting, index: true, foreign_key: true
      t.boolean :took_place
      t.string :course
      t.decimal :hours
      t.string :status, default: "pending" #options: pending, complete
      t.timestamps
    end
  end
end

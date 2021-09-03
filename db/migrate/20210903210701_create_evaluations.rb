class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.belongs_to :meeting, index: true, foreign_key: true
      t.boolean :took_place
      t.string :course
      t.decimal :hours
      t.string :status, default: "Pending"
      t.timestamps
    end

    add_column :evaluations, :hash_id, :string, index: true
    Evaluation.all.each{|m| m.set_hash_id; m.save}
  end
end

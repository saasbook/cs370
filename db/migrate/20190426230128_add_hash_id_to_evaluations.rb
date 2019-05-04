class AddHashIdToEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluations, :hash_id, :string, index: true
    Evaluation.all.each{|m| m.set_hash_id; m.save}
  end
end

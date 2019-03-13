class DropEvaluations < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :evaluation_id
    drop_table :evaluations
  end
end

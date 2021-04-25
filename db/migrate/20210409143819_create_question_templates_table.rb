class CreateQuestionTemplatesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :question_templates do |t|
      t.integer :order
      t.string :prompt
      t.boolean :is_optional
      t.string :question_type #text, scale, number?, what else?
      t.boolean :is_active
      t.timestamps

    end
  end
end

class CreateQuestionTemplatesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :question_templates do |t|
      t.string :prompt
      t.boolean :is_optional
      t.string :question_type #text, scale, number?, what else?
      t.timestamps

    end
  end
end

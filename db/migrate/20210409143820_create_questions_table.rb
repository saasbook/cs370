class CreateQuestionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :evaluation, foreign_key: true
      t.references :question_template, foreign_key: true
      t.text :response
      t.timestamps

    end
  end
end

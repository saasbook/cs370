class CreateQuestionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :evaluation, foreign_key: true
      t.references :question_template, foreign_key: true
      #Storing the prompt appears redundant, but is necessary in case a Question Template changes.
      #All we really need is the prompt and response to have a meaningful item to analyze.
      t.string :prompt
      t.text :response
      t.timestamps

    end
  end
end

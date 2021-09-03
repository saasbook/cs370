class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.belongs_to :question_template, foreign_key: true
      t.belongs_to :evaluation, foreign_key: true
      #Storing the prompt appears redundant, but is necessary in case a Question Template changes.
      #All we really need is the prompt and response to have a meaningful item to analyze.
      t.string :prompt
      t.text :response
      #this is necessary to store in case a private question is being asked, so when the tutor views their feedback they don't see what was meant for admin only.
      t.boolean :is_admin_only
      t.timestamps
    end
  end
end

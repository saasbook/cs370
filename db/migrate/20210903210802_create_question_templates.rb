class CreateQuestionTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :question_templates do |t|
      t.integer :order
      t.string :prompt, default: "Your Prompt Here"
      t.boolean :is_optional, default: false
      t.string :question_type, default: "text" #text, scale, number?, what else?
      t.boolean :is_active, default: true
      t.boolean :is_admin_only, default: false
      t.json :details, default: {:min_char=>50, :options=>"Your Options Here", :min_val=>1, :min_lab=>"Poor", :max_val=>7, :max_lab=>"Great"}
      t.timestamps
    end
  end
end

class CreateInitialTables < ActiveRecord::Migration[5.2]
  def change

    create_table :tutors do |t|
      t.string :type_of_tutor
      t.string :term
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.bigint :sid
      t.string :major
      t.boolean :dsp
      t.boolean :transfer
      t.timestamps
    end

    create_table :tutees do |t|
      t.integer :sid, :limit => 8
      t.string :first_name
      t.string :last_name
      t.string :email, null: false, unique: true
      t.string :gender
      t.string :pronoun
      t.string :ethnicity, array: true
      t.string :major
      t.boolean :dsp
      t.boolean :transfer
      t.string :term
      t.json :meta_values
      t.timestamps null: false
    end

    create_table :admins do |t|
      t.string :password_digest
      t.string :statistics_semester
      t.string :current_semester
      t.timestamps
    end

    create_table :requests do |t|
      t.references :tutee, foreign_key: true
      t.string :course
      t.integer :meeting_length, :limit => 2
      t.string :subject
      t.json :meta_values
      t.timestamps
    end

    create_table :evaluations do |t|
      t.boolean :took_place
      t.string :course
      t.decimal :hours
      t.string :status, :default => "Pending"
      t.timestamps
    end

    add_column :evaluations, :hash_id, :string, index: true
    Evaluation.all.each{|m| m.set_hash_id; m.save}

    create_table :meetings do |t|
      t.references :tutor, foreign_key: true
      t.references :tutee, foreign_key: true
      t.references :request, foreign_key: true
      t.references :evaluation, foreign_key: true
      t.datetime :set_time, default: nil
      t.string :set_location
      t.boolean :is_scheduled, default: false
      t.json :meta_values
      t.timestamps
    end
  end
end

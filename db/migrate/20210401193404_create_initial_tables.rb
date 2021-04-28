class CreateInitialTables < ActiveRecord::Migration[5.2]
  def change
    create_table :berkeley_classes do |t|
    	t.boolean :CS61A, default: false
    	t.boolean :CS61B, default: false
    	t.boolean :CS61C, default: false
    	t.boolean :CS70, default: false
    	t.boolean :EE16A, default: false
      t.boolean :EE16B, default: false
    	t.boolean :CS88, default: false
    	t.boolean :CS10, default: false
    	t.boolean :DATA8, default: false
      t.boolean :UPPERDIV, default: false
      t.boolean :OTHER, default: false
    end

    create_table :tutors do |t|
      t.string :type_of_tutor
      t.string :grade_level
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :gender
      t.bigint :sid
      t.string :major
      t.boolean :dsp?
      t.boolean :transfer?
      t.references :berkeley_classes, foreign_key: true
      t.timestamps
    end

    create_table :tutees do |t|
      t.integer :sid, :limit => 8
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :email, null: false, unique: true
      t.string :privilege
      t.string :gender
      t.string :pronoun
      t.string :ethnicity, array: true
      t.string :major
      t.boolean :dsp
      t.boolean :transfer
      t.string :year
      t.json :meta_values
      t.timestamps null: false
    end

    create_table :admins do |t|
      t.string :password_digest
      t.string :statistics_semester
      t.string :current_semester
      t.timestamps
    end

    create_table :courses do |t|
      t.integer :course_num
      t.string :name
      t.string :semester
      t.boolean :active, default: true
      t.json :meta_values
      t.timestamps
    end

    create_table :requests do |t|
      t.references :tutee, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :meeting_length, :limit => 2
      t.string :subject
      t.json :meta_values
      t.timestamps
    end

    create_table :evaluations do |t|
      t.boolean :took_place
      t.string :topics
      t.float :hours, :precision => 3, :scale => 2
      t.text :positive
      t.text :best
      t.text :feedback
      t.integer :knowledgeable, :limit => 1
      t.integer :helpful, :limit => 1
      t.integer :clarity, :limit => 1
      t.integer :pacing, :limit => 1
      t.text :final_comments
      t.string :status, :default => "Pending"
      t.timestamps
    end
    #I don't know what this hash_id is used for, but there are
    #Cucumber tests that look for it, so I guess we're
    #leaving it here. 04/01/2021
    add_column :evaluations, :hash_id, :string, index: true
    Evaluation.all.each{|m| m.set_hash_id; m.save}

    create_table :meetings do |t|
      t.references :tutor, foreign_key: true
      t.references :tutee, foreign_key: true
      t.references :request, foreign_key: true
      t.references :evaluation, foreign_key: true
      t.datetime :times, array: true, default: []
      t.datetime :set_time, default: nil
      t.string :locations, array: true, default: []
      t.string :set_location
      t.boolean :is_scheduled, default: false
      t.json :meta_values
      t.timestamps
    end




  end
end

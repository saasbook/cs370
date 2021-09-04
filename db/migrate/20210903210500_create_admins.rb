class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :password_digest
      t.string :course_list, array: true, default: ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV"]
      t.text :tutor_types, default: "CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)"
      t.string :priority_list, array: true
      t.boolean :signups_allowed, default: true
      t.timestamps
    end
  end
end

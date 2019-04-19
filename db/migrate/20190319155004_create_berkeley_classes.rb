class CreateBerkeleyClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :berkeley_classes do |t|
    	t.boolean :CS61A
    	t.boolean :CS61B 
    	t.boolean :CS61C 
    	t.boolean :CS70
    	t.boolean :EE16A
    	t.boolean :CS88
    	t.boolean :CS10
    	t.boolean :DATA8
    end
  end
end

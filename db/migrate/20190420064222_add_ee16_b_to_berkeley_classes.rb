class AddEe16BToBerkeleyClasses < ActiveRecord::Migration[5.2]
  def change
  	add_column :berkeley_classes, :EE16B, :boolean, default: false 
  end
end

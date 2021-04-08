class AddUpperDivAndOtherToBerkeleyClasses < ActiveRecord::Migration[5.2]
  def change
    add_column :berkeley_classes, :UPPERDIV, :boolean, default: false 
    add_column :berkeley_classes, :OTHER, :boolean, default: false 
  end
end

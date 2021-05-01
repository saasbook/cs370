class AddClosedToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :closed, :boolean, default: false
  end
end

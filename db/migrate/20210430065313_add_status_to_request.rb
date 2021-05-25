class AddStatusToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :status, :string, default: "open"
  end
end

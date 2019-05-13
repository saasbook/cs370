class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :password_digest
      t.string :statistics_semester
      t.string :current_semester

      t.timestamps
    end
  end
end

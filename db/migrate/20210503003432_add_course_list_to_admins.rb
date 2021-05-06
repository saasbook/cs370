class AddCourseListToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :course_list, :string, :array=>true
  end
end

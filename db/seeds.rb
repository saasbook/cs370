course_list = ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV", "OTHER"]

course_list.each_with_index do |course, i|
  Course.create!(:course_num => i + 1, :name => course, :semester => "Spring 2019")
end
class Course < ApplicationRecord
  has_many :requests
  # class functions
  class<<self
    def current_semester
      return Admin.current_semester
    end

    def current_courses_formatted
      formated_string = ""
      self.where(semester: current_semester).pluck(:name).each do |course_name|
        formated_string += course_name +"\n"
      end
      return formated_string[0..-2] # removes the final \n from the string
    end

    def current_active_courses
      self.where(:semester => self.current_semester).all.map { |course| [course.name, course.id] }
    end

    #accepts a string separated by '\n'
    def update_courses(courses)
      puts(courses)
      courses = courses.to_s.split("\r\n").map { |c| c.upcase.gsub(/\s+/, "") }.map{ |name| {:name => name}} #split, remove spaces/capitialize, and turn into an array of hashes
      #should now look like ex: [{:name => CS61A}, {:name => CS170}]
      # can verify correctness of hashes by uncommenting lines below
      # courses2.each do |c|
      #   puts(c[:name])
      # end

      # update all current_semester_courses to be inactive
      self.where(semester: current_semester)
      # add courses to semester or update existing courses to active.
      courses.each do |course|
        @c = self.where(course).first_or_create do |c|
          c.semester = self.current_semester
        end
      end

      #need to update the courses to have an active variable and requests controller to check only for active courses.

      # verify that the number of courses is now the same.
      return self.where(semester: current_semester).count == courses.count
    end

  end
end

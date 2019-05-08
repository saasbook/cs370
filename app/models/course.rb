class Course < ApplicationRecord
  has_many :requests
  # class functions
  class<<self
    def current_semester
      return Admin.current_semester
    end

    def current_courses_formatted
      formated_string = ""
      self.current_active_courses.pluck(:name).each do |course_name|
        formated_string += course_name +"\r\n"
      end
      return formated_string[0..-2] # removes the final \n from the string
    end

    def current_active_courses
      self.where(:semester => self.current_semester, :active => true)
    end

    # used to convert all active courses into an array
    def course_array
      self.current_active_courses.all.map { |course| [course.name, course.id] }
    end

    #accepts a string separated by '\n'
    def update_courses(courses)
      puts(courses)
      courses = courses.to_s.split("\r\n").map { |c| c.upcase.gsub(/\s+/, "") }.map{ |name| {:name => name, :semester => self.current_semester}} #split, remove spaces/capitialize, and turn into an array of hashes
      #should now look like ex: [{:name => CS61A}, {:name => CS170}]
      # can verify correctness of hashes by uncommenting lines below
      # courses2.each do |c|
      #   puts(c[:name])
      # end



      # update all current_semester_courses to be inactive
      self.where(semester: self.current_semester).update_all(:active => false)


      # find existing courses and update to active or create new courses
      courses.each do |course|
        @c = self.where(course).first_or_create
        @c.update(:active => true)
      end

      # verify that the number of active courses is now the same.
      return self.current_active_courses.count == courses.uniq.count
    end


  end
end

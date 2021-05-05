@javascript
Feature: Update Courses
  As a admin
  I want to update the courses
  So that new courses can be added or removed

  Background: I am on the Manage Semester admin page and update the course list
    And I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I should see "Update Courses"
    Then I should see courses "CS10, CS61A, CS61B, CS61C, CS70, CS88, EE16A, EE16B, DATA8, UPPERDIV"
    When I update courses to "VERY COOL, THANKS, NOT A REAL CLASS"
    And I press "Update Course List"
    Then I should see "Course list successfully updated"
    Then I should see courses "VERY COOL, THANKS, NOT A REAL CLASS"
    Then I should not see courses "CS10, CS61A, CS61B, CS61C, CS70, CS88, EE16A, EE16B, DATA8, UPPERDIV"

  Scenario: Tutees should see updated course list after changes
    When I press link "Log out"
    And I log in as "Tutee" "Three"
    And I press link "Request"
    Then I should see "Create a Request"
    And I should see "Please pick a course:"
    And I should see "VERY COOL"

@javascript
Feature: Update Semester
  As a admin
  I want to update the courses
  So that new courses can be added or removed

  Background: There exists an admin
    Given I log in as admin
    Then I should be on the admin home page
    When I press link "Update Courses"
    Then I should be on the update courses page

  Scenario: Feature coming soon
    Then I should see "Coming soon!"

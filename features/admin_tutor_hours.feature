@javascript
Feature: Show tutor hours
  As an admin
  So that I need to check how many hours each tutor've done so far
  I can see the table from all tutors with total hours of each one

  Background: I am logged in as Admin
    Given I log in as admin

  Scenario: Try to click on Tutor Hours tab
    Then I should be on the admin home page
    And I click on "Tutor Hours" link
    And I can see tutor "Tutor One" with tutor hours 2.0
    And I can see tutor "Tutor Two" with tutor hours 9.0
    And I can see tutor "Tutor Three" with tutor hours 0.0

  Scenario: Download tutor hours as csv
    Then I should be on the admin home page
    And I click on "Tutor Hours" link
    And I can see tutor "Tutor One" with tutor hours 2.0
    And I can see tutor "Tutor Two" with tutor hours 9.0
    And I can see tutor "Tutor Three" with tutor hours 0.0
    When I download "export1"
    Then the download should have the filename "tutor-hours-"
    When I go to the tutor hours page
    And I download "export2"
    Then the download should have the filename "demographic-hours-"
    When I go to the tutor hours page
    And I download "export3"
    Then the download should have the filename "course-hours-"

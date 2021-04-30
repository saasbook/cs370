@javascript
Feature: Update Semester
  As a admin
  I want to update the semester
  So that the semester is updated on every semester

  Background: There exists an admin
    Given I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I can see current semester "Current Semester: Spring 2021" title

  Scenario: Admin can update current semester - valid input year
    When I make an update for current semester to "Fall 2021"
    And I confirm popup
    And I can see current semester "Current Semester: Fall 2021" title

  Scenario: Admin can update current semester - invalid input year
    When I make an update for current semester to "Fall OskiYear"
    And I confirm popup
    Then I can see "Error updating current semester, year is likely mistyped" message pop up

#  Scenario: Admin can update semester statistic - valid input year
#    When I make an update for semester statistic to "Fall 2020"
#    And I can see semester statistic "Semester Statistics Are Shown For: Fall 2020" title at admin home page

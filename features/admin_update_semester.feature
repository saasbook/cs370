Feature: Update Semester
  As a admin
  I want to update the semester
  So that the semester is updated on every semester

  Background: There exists an admin
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Update Semester"
    Then I should be on the update semester page
    And I can see current semester "Current Semester: Spring 2019" title at admin home page

  Scenario: Admin can update current semester - valid input year
    When I make an update for current semester to "Fall 2020"
    And I can see current semester "Current Semester: Fall 2020" title at admin home page

  Scenario: Admin can update current semester - invalid input year
    When I make an update for current semester to "Fall OskiYear"
    And I can see "Error updating current semester, year is likely mistyped" message pop up

  Scenario: Admin can update semester statistic - valid input year
    When I make an update for semester statistic to "Fall 2020"
    And I can see semester statistic "Semester Statistics Are Shown For: Fall 2020" title at admin home page

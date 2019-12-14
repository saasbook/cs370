Feature: Update Semester
  As a admin
  I want to update the courses
  So that new courses can be added or removed

  Background: There exists an admin
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |
    And the following courses exist:
      | name  | semester   |
      | CS162 | Spring2019 |
      | CS61A | Spring2019 |
      | CS168 | Spring2019 |

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Update Courses"
    Then I should be on the update courses page

  Scenario: Feature coming soon
    Then I should see "Coming soon!"
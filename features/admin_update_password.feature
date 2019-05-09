Feature: Update Password
  As a admin
  I want to update the password
  So that I can change admins without old members being able to access the admin page

  Background: There exists an admin
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    And I am on the update admin password page

  Scenario: Admin can update password
    When I update admin password with password "goodPassword" and confirmation password "goodPassword"
    Then I can see "Admin password successfully updated." message pop up


  Scenario: Passwords must match
    When I update admin password with password "goodPassword" and confirmation password "badPassword"
    Then I can see "Passwords do not match" message pop up
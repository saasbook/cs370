@javascript
Feature: Update Password
  As a admin
  I want to update the password
  So that I can change admins without old members being able to access the admin page

  Background: There exists an admin
    Given I log in as admin
    Then I should be on the admin home page
    When I click on "Update Password" link
    Then I should be on the update admin password page

  Scenario: Admin can update password
    When I update admin password with password "goodPassword" and confirmation password "goodPassword"
    And I confirm popup
    Then I can see "Admin password successfully updated." message pop up


  Scenario: Passwords must match
    When I update admin password with password "goodPassword" and confirmation password "badPassword"
    And I confirm popup
    Then I can see "Passwords do not match" message pop up

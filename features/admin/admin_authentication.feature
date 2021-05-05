@javascript
Feature: Verify Admin Authentication
  As an admin
  I don't want unauthorized people accessing admin pages
  So that my data stays secure

  Scenario: Admin with password can visit admin home page
    When I log in as admin
    Then I should be on the admin home page

  Scenario: Admin without password cannot visit admin home page
    When I want to log in as user type "Admin"
    And I fill in "password" with "wrongAdminPassword"
    And press "Log in"
    Then I should be on the home page

  Scenario: No one can get to admin pages without logging in first
    Given I am on the home page
    When I am on the admin home page
    Then I should be on the home page

  Scenario: Admin can log out
    When I log in as admin
    When I press link "Log Out"
    Then I should be on the home page

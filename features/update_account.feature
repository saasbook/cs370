Feature: Tutee can update an account information

  As a current user
  I want to edit my account information
  So that I can ensure my profile is up to date

  Background: User has an acocunt
    Given the following tutees exist:
      | sid        | first_name | last_name | email                   | birthdate  | password  | password_confirmation | confirmed_at        |
      | 12345678   | Bob        | Burgers   | bobburgers@berkeley.edu | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
    And I am on the login page
    And I fill in "username" with "bobburgers@berkeley.edu"
    And I fill in "password" with "topsecret"
    And I press "Log in"
    Then I should be on the user page for "bobburgers@berkeley.edu"
    Then press link "Edit Info"
    Then I should be on the update page for "bobburgers@berkeley.edu"

  Scenario: update first name successfully
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "First Name" to "Bobby"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "Your account has been updated successfully."
    And I should be on the user page for "bobburgers@berkeley.edu"

  Scenario: update last name successfully
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Last Name" to "Hotdogs"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "Your account has been updated successfully."
    And I should be on the user page for "bobburgers@berkeley.edu"

  Scenario: update birthdate successfully
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Birthdate" to "1993-06-19"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "Your account has been updated successfully."
    And I should be on the user page for "bobburgers@berkeley.edu"

  Scenario: update sid successfully
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Student SID" to "987654321"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "Your account has been updated successfully."
    And I should be on the user page for "bobburgers@berkeley.edu"

  Scenario: Try to update account with missing first name field
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "First Name" to ""
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "1 error prohibited this tutee from being saved:"

  Scenario: Try to update account with missing last name field
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Last Name" to ""
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "1 error prohibited this tutee from being saved:"

  Scenario: Try to update account with account with digits in first name field
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "First Name" to "Bob123"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "1 error prohibited this tutee from being saved:"

  Scenario: Try to update account with account with digits in last name field
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Last Name" to "Burgers123"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "1 error prohibited this tutee from being saved:"

  Scenario: Try to update account with missing birthdate field
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Birthdate" to ""
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "2 errors prohibited this tutee from being saved:"

  Scenario: Try to update account with invalid birthdate format
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Birthdate" to "06-19-1992"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "2 errors prohibited this tutee from being saved:"

  Scenario: Try to update account with future birthdate
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Birthdate" to "3030-06-19"
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "1 error prohibited this tutee from being saved:"

  Scenario: Try to update account with missing sid field
    Given I am on the update page for "bobburgers@berkeley.edu"
    And I change "Student SID" to ""
    And I fill in "tutee_current_password" with "topsecret"
    And I press "Save Changes"
    Then I should see "3 errors prohibited this tutee from being saved:"

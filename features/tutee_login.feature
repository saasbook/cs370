Feature: Tutee can log in

  As a current tutee
  I want to log in
  So that I can request tutoring

  Background: A tutee exists
    Given the following tutees exist:
      | sid        | first_name | last_name | email                   | birthdate  | password  | password_confirmation | confirmed_at        |
      | 12345678   | Bob        | Burgers   | bobburgers@berkeley.edu | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 12344533   | Tom        | Jerry     | tomjerry@berkeley.edu   | 1992-01-01 | topsecret | topsecret             |                     |

  Scenario: Login successfully
    Given I am on the login page
    And I fill in "username" with "bobburgers@berkeley.edu"
    And I fill in "password" with "topsecret"
    And I press "Log in"
    Then I should see "Dashboard"
    And I should be on the user page for "bobburgers@berkeley.edu"
    When I go to the login page
    Then I should be on the user page for "bobburgers@berkeley.edu"
    When I click on "Logout" link
    Then I should be on the login page

  Scenario: Login unsuccessfully
    Given I am on the login page
    And I fill in "username" with "bobburgers@berkeley.edu"
    And I fill in "password" with "topdog"
    And I press "Log in"
    Then I should see "Invalid Email or password."
    And I should be on the login page

  Scenario: Login with unconfirmed account
    Given I am on the login page
    And I fill in "username" with "tomjerry@berkeley.edu"
    And I fill in "password" with "topsecret"
    And I press "Log in"
    Then I should see "You have to confirm your email address before continuing."
    And I should be on the login page

Feature: Tutee can log in

  As a current tutee
  I want to log in
  So that I can request tutoring

  Scenario: Login successfully
    Given a valid tutee
    When I am on the login page
    And I fill in "username" with "bobburgers@berkeley.edu"
    And I fill in "password" with "topsecret"
    And I press "Log in"
    Then I should see "Dashboard"
    And I should be on the user page for "bobburgers@berkeley.edu"

  Scenario: Login unsuccessfully
    Given a valid tutee
    When I am on the login page
    And I fill in "username" with "bobburgers@berkeley.edu"
    And I fill in "password" with "topdog"
    And I press "Log in"
    Then I should see "Invalid Email or password."
    And I should be on the login page

#  Scenario: Login with unconfirmed account
#    Given an unconfirmed tutee
#    When I am on the login page
#    And I fill in "username" with "bobby@berkeley.edu"
#    And I fill in "password" with "topsecret"
#    And I press "Log in"
#    Then I should see "You have to confirm your email address before continuing."
#    And I should be on the login page


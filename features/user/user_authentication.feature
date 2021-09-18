@javascript
Feature: Verify User Authentication
  As a User
  I dont want unauthorized people to access my profile
  So that my data stays secure

  Background: There exists a tutee and courses
    Given I am on the home page

  Scenario: User cannot access dashboards without signing in first
    When I go to the dashboard
    Then I should be on the home page
    And I should see "You need to sign in or sign up before continuing."

  Scenario: Tutor can log in and visit their own profile
    When I log in with email "tr1@berkeley.edu" and password "111111"
    Then I should see "Your Statistics"
    And I should see "Upcoming Meetings"
    When I refresh
    Then I should see "Your Statistics"
    And I should see "Upcoming Meetings"

  Scenario: Tutee can log in and visit their own profile
    When I log in with email "tt1@berkeley.edu" and password "111111"
    Then I should see "Welcome, Tutee"
    And I should see "Current Request"
    And I should see "Previous Requests"

  Scenario: User can log out
    When I log in with email "tr1@berkeley.edu" and password "111111"
    And I press "Log Out"
    Then I should be on the home page

  Scenario: Login with unconfirmed account
    Given the following users exist:
      |type | first_name | last_name | email                   | pronoun |gender  |major |dsp |transfer|term| ethnicity | password  | password_confirmation | confirmed_at         |
      |Tutor| Tom        | Jerry     | tomjerry@berkeley.edu   | He/His  |Male    |Cheese|true| false  |  2 | White     |topsecret | topsecret             |                      |
    Given I am on the home page
    When I log in with email "tomjerry@berkeley.edu" and password "topsecret"
    Then I should be on the home page
    And I should see "You have to confirm your email address before continuing"

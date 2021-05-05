@javascript
Feature: Verify Tutor Authentication
  As a Tutor
  I dont want unauthorized people to access my profile
  So that my data stays secure

  Background: There exists a tutee and courses
    Given I am on the home page

  Scenario: Tutor can log in and visit their own profile
    When I log in as "Tutor" "One"
    Then I should be on the "One's" tutor page
    When I refresh
    Then I should be on the "One's" tutor page

  Scenario: Tutor cannot access another tutor's profile by url modification
    Given I am on "One's" tutor page
    When I go to "Two's" tutor page
    Then I should be on the home page

  Scenario: Tutor can log out
    Given I log in as "Tutor" "One"
    When I press "Log Out"
    Then I should be on the home page


  Scenario: Login with unconfirmed account
    Given the following tutors exist:
      | sid        | first_name | last_name | email                   |type_of_tutor| gender  |major |dsp |transfer|term| password  | password_confirmation | confirmed_at         |
      | 12344533   | Tom        | Jerry     | tomjerry@berkeley.edu   |TA (12 hours)| Male    |Cheese|true| false  |  2 | topsecret | topsecret             |                      |
    Given I am on the home page
    And I want to log in as user type "Tutor"
    And I fill in "username" with "tomjerry@berkeley.edu"
    And I fill in "password" with "topsecret"
    And I press "Log in"
    Then I should be on the home page
    And I should see "You have to confirm your email address before continuing"

@javascript
Feature: Verify Tutee Authentication
  As a Tutee
  I dont want unauthorized people to access my profile
  So that my data stays secure

  Background: There exists a tutee and courses
    Given I am on the home page

  Scenario: Tutee can log in and visit their own profile
    When I log in as "Tutee" "One"
    Then I should be on the "One's" tutee page

  Scenario: Tutee cannot access another tutee's profile by url modification
    Given I am on "One's" tutee page
    When I go to "Two's" tutee page
    Then I should be on the home page

  Scenario: Tutee can log out
    Given I log in as "Tutee" "One"
    When I press link "Log Out"
    Then I should be on the home page


  Scenario: Login with unconfirmed account
    Given the following tutees exist:
      | sid        | first_name | last_name | email                   | gender|pronoun|  ethnicity  |major |dsp |transfer|term| password  | password_confirmation | confirmed_at         |
      | 12344533   | Tom        | Jerry     | tomjerry@berkeley.edu   | Male  |He/Him |  Cat Mouse  |Cheese|true| false  |  2 | topsecret | topsecret             |                      |
    Given I am on the home page
    And I want to log in as user type "Tutee"
    And I fill in "username" with "tomjerry@berkeley.edu"
    And I fill in "password" with "topsecret"
    And I press "Log in"
    Then I should be on the home page
    And I should see "You have to confirm your email address before continuing."

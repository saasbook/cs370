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
    When I press link "Logout"
    Then I should be on the home page

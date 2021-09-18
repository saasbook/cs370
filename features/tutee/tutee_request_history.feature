@javascript
Feature: see history request
  As a tutee
  I want to know my tutoring history

  Background: meetings has been added to the database
    Given I log in with email "tt1@berkeley.edu" and password "111111"

  Scenario: Try to click on history tab given that I have history
    When I click on "Previous Requests" link
    Then I should see "CS61A"
    And I should see "seeded request tutee 1 - 1"
    And I should see "CS10"
    And I should see "seeded request tutee 1 - 2"

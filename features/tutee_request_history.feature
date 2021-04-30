@javascript
Feature: see history request
  As a tutee
  I want to know my tutoring history

  Background: meetings has been added to the database
    Given I log in as "Tutee" "One"

  Scenario: Try to click on history tab given that I have history
    Then I should be on "One's" tutee page
    When I click on "History" link
    Then I should see "Tutor One"
    And I should see "Tutor Two"
    And I should see "seeded request tutee 1"
    And I should see "Complete"

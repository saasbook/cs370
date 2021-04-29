@javascript
Feature: See Tutor Rating
  As an admin
  I want to update the semester
  So that the semester is updated on every semester

  Background: Admin is logged in
    Given I log in as admin

  Scenario: Admin can see tutor rating
    When I click on "Tutor Ratings" link
    Then I should be on the rating tutors page
    And I can see the tutor name "Tutor One"
    And I can see the composite score of "5.0"

  Scenario: Tutor with multiple evaluations has average score
    When I click on "Tutor Ratings" link
    Then I should be on the rating tutors page
    And I can see the tutor name "Tutor Two"
    And I can see the composite score of "3.33"

  Scenario: Download the ratings as a csv
    When I click on "Tutor Ratings" link
    Then I should be on the rating tutors page
    Then I click on "Export as CSV" link
    Then I should get a csv download with the filename "tutor-ratings-" date

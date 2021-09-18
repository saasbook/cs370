@javascript
Feature: Tutor can view evaluations from completed meetings

  As a current tutor
  I want to view my previous evaluations
  So that I can get feedback and improve my performance

  Background:
    Given I log in with email "tr2@berkeley.edu" and password "111111"

  Scenario: Viewing a finished evaluation
    Then I should see "Your Statistics"
    When I follow "Previous Meetings"
    Then I should see "seeded request tutee 1 - 1"
    And I should see "seeded request tutee 2 - 1"
    And I should see "seeded request tutee 3 - 1"

    When I click on the element with id "row_0"
    Then I should see "Your Evaluation"
    And I should not see "Your Statistics"
    And I should see "What course did you receive tutoring in?"
    And I should see "How many hours of tutoring did you receive?"

#Once again, this would be best if there was already an incomplete evaluation. Temporary solution, left to FactoryBot overhaul.
  Scenario: Viewing an incomplete evaluation
    When I click on the element with id "row_0"
    And I fill date "meeting_date" with "12/04/12"
    And I fill time "meeting_time" with "08:30AM"
    And I fill in "meeting_location" with "Moffitt"
    And I press "Confirm Meeting"
    And I click on the element with id "row_0"
    And I press "Finish Meeting"
    And I confirm popup
    Then I should see "Your Statistics"

    When I follow "Previous Meetings"
    Then I should see "Moffitt"
    When I click on the element with id "row_3"
    Then I should see "Your Evaluation"
    And I should not see "Your Statistics"
    And I should see "This evaluation is not ready."
    And I should not see "What course did you receive tutoring in?"
    And I should not see "How many hours of tutoring did you receive?"

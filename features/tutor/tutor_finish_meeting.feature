@javascript
#Optimally, this should run off a Tutor who already has a confirmed meeting, so as to keep the tests separate.
#Change left to future FactoryBot overhaul.
Feature: Tutor can finish a meeting with student

  As a current tutor
  I want to finish a meeting
  So that I can earn hours and get an evaluation

  Background: A tutee exists
    Given I log in as "Tutor" "Two"

  Scenario: Finishing a Meeting
    When I click on the element with id "row_0"
    And I fill date "meeting_date" with "12/04/12"
    And I fill time "meeting_time" with "08:30AM"
    And I fill in "meeting_location" with "Moffitt"
    And I press "Confirm Meeting"

    Then I should see "Moffitt"
    And I should see "Your Statistics"
    When I click on the element with id "row_0"
    Then I should see "Finish Meeting"
    And I should not see "Your Statistics"

    When I press link "Finish Meeting"
    And I confirm popup
    Then I should see "Your meeting was successfully finished."
    And I should see "Your Statistics"
    And I should see "You have no upcoming meetings, find tutees to tutor in the adjacent tab."

@javascript
Feature: Tutor confirms a meeting with student

  As a current tutor
  I want to confirm a meeting
  So that I can eventually finish it to earn hours

  Background: A tutee exists
    Given I log in as "Tutor" "Two"

  Scenario: Selecting a Student Successfully
    Then I should be on "Two's" tutor page
    And I should see "Upcoming Meetings"
    And I should see "Find Tutees"
    And I should see "Previous Meetings"
    And I should see "Your Statistics"

    And I should see "Tutee Two"
    And I should see "seeded request tutee 2 - 2"
    And I should see "Pending Confirmation"

    When I click on the element with id "row_0"
    Then I should see "Meeting Details"
    And I should not see "Your Statistics"
    And I should see "Your meeting with:"
    And I should see "Tutee Two"

    When I fill date "meeting_date" with "12/04/12"
    And I fill time "meeting_time" with "08:30AM"
    And I fill in "meeting_location" with "Moffitt"
    And I press "Confirm Meeting"
    Then I should see "Successfully confirmed meeting details!"
    And I should see "Your Statistics"
    And I should see "Moffitt"
    And I should not see "Pending Confirmation"

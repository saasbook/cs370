@javascript

Feature: Tutor can select a student and propose to meet

  As a current tutor
  I want see all the students
  So that I can select a student to tutor

  Background: A tutee exists
    Given I log in as "Tutor" "Two"

  Scenario: Selecting a Student Successfully
    Then I should be on "Two's" tutor page
    And I should see "Upcoming Meetings"
    And I should see "Find Tutees"
    And I should see "Previous Meetings"

    And I should see "Tutee Two"
    And I should see "seeded request tutee 2 - 2"
    And I should see "Pending Confirmation"
    And I should not see "CS61B"
    And I should not see "seeded request tutee 1 - 3"

    When I follow "Find Tutees"
    Then I should see "CS61B"
    When I follow "CS61B"
    Then I should see "Tutee One"
    And I should see "seeded request tutee 1 - 3"
    And I should not see "Tutee Two"
    And I should not see "seeded request tutee 2 - 2"

    When I click on the element with id "row_0"
    Then I should see "Send Invitation"
    And I should not see "Your Statistics"
    When I press "Send Invite"
    Then I should see "Successfully matched!"
    And I should see "Your Statistics"
    And I should see "CS61A"
    And I should see "CS61B"
    And I should see "Tutee One"
    And I should see "Tutee Two"
    And I should not see "CS70"

Feature: Tutor can confirm a meeting with student

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

    When I press "Finish Meeting"
    And I confirm popup
    Then I should see "Your meeting was successfully finished."
    And I should see "Your Statistics"
    And I should see "You have no upcoming meetings, find tutees to tutor in the adjacent tab."

Feature: Tutor can view evaluations from completed meetings

  As a current tutor
  I want to view my previous evaluations
  So that I can get feedback and improve my performance

  Background:
    Given I log in as "Tutor Two"

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
    Background:
      Given the following 

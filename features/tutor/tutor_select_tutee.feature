@javascript
Feature: Tutor can select a student and propose to meet

  As a current tutor
  I want see all the students
  So that I can select a student to tutor

  Background: A tutee exists
    Given I log in with email "tr2@berkeley.edu" and password "111111"

  Scenario: Selecting a Student Successfully
    Then I should see "Upcoming Meetings"
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

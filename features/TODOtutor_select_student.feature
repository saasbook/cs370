@javascript
Feature: Tutor selects a student

  As a current tutor
  I want see all the students
  So that I can select a student to tutor

  Background: A tutee exists
    Given I log in as "Tutor" "One"

  Scenario: Selecting a Student Successfully
    Then I should be on "One's" tutor page
    And I go to the find students page for "tr1@berkeley.edu"
    And I should see "Tutee One"
    And I follow "CS61A"
    And I press "Select Student"
    #TODO get the Epic implemented to remove the three timeslot system and skip to an email system.
    Then I should see "There are no students in the queue for CS61A"

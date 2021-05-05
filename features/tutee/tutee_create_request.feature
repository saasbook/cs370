@javascript
Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given I log in as "Tutee" "Three"

  Scenario: Request for Tutoring for Student with Priority
    Then I should be on "Three's" tutee page
    When I follow link "Request"
    Then I should see "Create a Request"
    And I should see "Please pick a course:"
    And I should see "What topics would you like to cover?"
    And I should see "Please select how long you would like to meet for:"
    When I select "CS61A" from "request_course"
    And I fill in "request_subject" with "Environment Diagrams big sadge"
    And I select "2 hours" from "request_meeting_length"
    And I press "Request Tutor"
    Then I should see "Tutoring request for class CS61A was successfully created!"
    And I should be on "Three's" tutee page

@javascript
Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given I log in with email "tt3@berkeley.edu" and password "111111"
    Then I should see "Signed in successfully."

  Scenario: Request for Tutoring for Student with Priority
    Then I should see "No request pending"
    And I should see "Please pick a course:"
    And I should see "What topics would you like to cover?"
    #TT3 is a CS Scholar, so they should be able to change the duration of their request
    And I should see "Please select how long you would like to meet for:"
    When I select "CS61A" from "request_course"
    And I fill in "request_subject" with "Environment Diagrams big sadge"
    And I select "2 hours" from "request_meeting_length"
    And I press "Make Request"
    Then I should see "Tutoring request for class CS61A was successfully created!"
    And I should see "Request submitted"

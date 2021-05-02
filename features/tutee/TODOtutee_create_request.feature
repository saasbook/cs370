@javascript
Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given I log in as "Tutee" "Three"

  Scenario: Request for tutoring
    Then I should be on "Three's" tutee page
    When I make a request for "CS61A" with topic "recursive"
    And I select Request tutor button
    Then I can see "Tutoring request for class CS61A was successfully created!" message pop up


#  Scenario: Request for tutoring - Invalid request
#    Then I should be on "Three's" tutee page
#    When I make a request for "CS61A" without inputting topic
#    And I select Request tutor button
#    Then I see the element with id "request_subject" raise a validation error "Cannot bes empty"
#TODO: either figure out how to detect validity error message or how to detect the absence of a redirect
#    Then I should not be redirected
#TODO: Implement new priority system

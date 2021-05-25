@javascript
Feature:
  As an admin
  So that I can have set periods where students can be matched
  I want to be able to close unmatched requests

  Background:
    Given I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I press link "Close All Unmatched Requests"
    And I confirm popup

  Scenario: Unmatched Requests are Closed
    Given I log in as "Tutee" "One"
    Given I am on "One's" tutee page
    When I press link "Request"
    Then I should see "Your last request was closed by admin."
    And I should see "Create a Request"

  Scenario: Matched Requests are not closed
    Given I log in as "Tutee" "Two"
    Given I am on "Two's" tutee page
    When I press link "Request"
    Then I should see "Your request has been matched! Please fill out the evaluation form after your meeting."

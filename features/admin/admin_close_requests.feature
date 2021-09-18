@javascript
Feature: Close Requests as Admin
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
    When I log in with email "tt1@berkeley.edu" and password "111111"
    Then I should see "Signed in successfully"
    Then I should see "Your request was closed by admin, please submit a new request."

  Scenario: Matched Requests are not closed
    When I log in with email "tt2@berkeley.edu" and password "111111"
    Then I should see "Request matched! Please check your email to confirm a meeting time with your tutor."
    When I press link "Previous Requests"
    Then I should not see "closed by admin."

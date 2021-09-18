@javascript
Feature:
  As an admin
  So that I can control when students can submit requests
  I want to be able to turn signups on and off

  Background: I am on the Manage Semester admin page
    And I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I should see "Turn Off Signups"

  Scenario: Turn off signups
    When I press link "Turn Off Signups"
    And I log in with email "tt3@berkeley.edu" and password "111111"
    Then I should see "Tutoring signups are closed at this time, please keep an eye on announcements for when they will reopen!"
    And I should not see "Please pick a course"

  Scenario: Turn on signups
    When I press link "Turn Off Signups"
    And I refresh
    Then I should see "Turn On Signups"
    When I press link "Turn On Signups"
    And I log in with email "tt3@berkeley.edu" and password "111111"
    Then I should see "Please pick a course:"

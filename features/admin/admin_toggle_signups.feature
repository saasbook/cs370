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
    And I log in as "Tutee" "Three"
    Then I should be on "Three's" tutee page
    Then I should not see "Edit Request"
    When I press link "Request"
    Then I should see "Signups for tutoring are currently closed."

  Scenario: Turn on signups
    When I press link "Turn Off Signups"
    And I refresh
    Then I should see "Turn On Signups"
    When I press link "Turn On Signups"
    And I log in as "Tutee" "Three"
    Then I should be on "Three's" tutee page
    Then I should not see "Edit Request"
    When I press link "Request"
    Then I should see "Please pick a course:"

  Scenario: Turn signups off, then back on
    When I press link "Turn Off Signups"
    And I press link "Log out"
    And I log in as "Tutee" "Three"
    Then I should be on "Three's" tutee page
    Then I should not see "Edit Request"
    When I press link "Request"
    Then I should see "Signups for tutoring are currently closed."

    When I log in as admin
    Then I should be on the admin home page
    When I press link "Manage Semester"
    And I press link "Turn On Signups"

    And I am on "Three's" tutee page
    Then I should not see "Edit Request"
    When I press link "Request"
    Then I should see "Please pick a course:"

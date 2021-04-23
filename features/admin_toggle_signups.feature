Feature: 
  As an admin
  So that I can control when students can submit requests
  I want to be able to turn signups on and off

  Background: There exists a tutee and courses

    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Sp2019           | Sp2019              |

    Given the following tutees exist:
      | sid       | first_name | last_name | email                   | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 123456789 | ann         | ju        | ann.juu@berkeley.edu     | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |


    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I should see "Turn Off Signups"

  Scenario: Turn off signups
    When I press link "Turn Off Signups"
    Given I login as "ann"
    Given I am on "ann's" tutee page
    When I press link "Request"
    Then I should see "Signups for tutoring are currently closed."

  Scenario: Turn on signups
    Given signups are off
    When I press link "Turn Off Signups"
    Given I login as "ann"
    Given I am on "ann's" tutee page
    When I press link "Request"
    Then I should see "Please pick a course:"

  Scenario: Turn signups off, then back on
    When I press link "Turn Off Signups"

    Given I login as "ann"
    Given I am on "ann's" tutee page
    When I press link "Request"
    Then I should see "Signups for tutoring are currently closed."

    When I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    When I press link "Manage Semester"
    When I press link "Turn On Signups"

    Given I am on "ann's" tutee page
    When I press link "Request"
    Then I should see "Please pick a course:"

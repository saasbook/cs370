Feature: Verify Tutee Authentication
  As a Tutee
  I dont want unauthorized people to access my profile
  So that my data stays secure

  Background: There exists a tutee and courses
    Given the following tutees exist:
    | sid       | first_name | last_name | email                   | birthdate  | password  | password_confirmation | confirmed_at        |
    | 1123111   | notan      | Burgers   | notan.ju@berkeley.edu   | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
    | 1123123   | jack       | Burgers   | jack@berkeley.edu       | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |

    And I am on the login page

  Scenario: Tutee can log-in and visit their own profile
    When I fill in "username" with "notan.ju@berkeley.edu"
    And I fill in "password" with "topsecret"
    And press "Log in"
    Then I should be on the "notan's" tutee page

  Scenario: Tutee cannot access another tutee's profile by url modification
    Given I am on "notan's" tutee page
    When I go to "jack's" tutee page
    Then I should be on the login page

  Scenario: Tutee can log out
    Given I login as "jack"
    When I press link "Logout"
    Then I should be on the login page
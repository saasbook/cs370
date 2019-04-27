Feature: Verify Tutee Authentication
  As a Tutee
  I dont want unauthorized people to access my profile
  So that my data stays secure

  Background: There exists a tutee and courses
    Given the following tutees exist:
    | sid       | first_name | last_name | email                   | birthdate  |
    | 1123111   | notan      | Burgers   | notan.ju@berkeley.edu   | 1992-01-01 |
    | 1123123   | jack       | Burgers   | jack@berkeley.edu       | 1992-01-01 |

    And I am on the login page

  Scenario: Tutee can log-in and visit their own profile
    When I fill in "username" with "notan.ju@berkeley.edu"
    And press "submit"
    Then I should be on the "notan's" tutee page

  Scenario: Tutee cannot access another tutee's profile by url modification
    Given I am on "notan's" tutee page
#    When I make a "GET" request to "/tutees/11"
#    When I try to access "jack's" profile
#    When I go to url "tutees/11"
    When I go to "jack's" tutee page
    Then I should be on the login page

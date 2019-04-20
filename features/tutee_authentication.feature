Feature: Verify Tutee Authentication
  As a Tutee
  I dont want unauthorized people to access my profile
  So that my data stays secure

  Background: There exists a tutee and courses
    Given the following tutees exist:
      | sid | first_name | last_name | email         | privilege |
      | 10   | an        | ju        | an.ju@cal.ber | CSS       |
      | 11   | jack      | brown     | jbee@cal.ber  | CSS       |

    And I am on the login page

  Scenario: Tutee can log-in and visit their own profile
    When I fill in "username" with "an.ju@cal.ber"
    And press "submit"
    Then I should be on the "an's" tutee page

  Scenario: Tutee cannot access another tutee's profile by url modification
    Given I am on "an's" tutee page
#    When I make a "GET" request to "/tutees/11"
#    When I try to access "jack's" profile
#    When I go to url "tutees/11"
    When I go to "jack's" tutee page
    Then I should be on the login page

  Scenario: Tutee cannot access non-existance profile of other tutee
    Given I am on "an's" tutee page
    When I go to the user page for "non-existance"
    Then I should be on the login page





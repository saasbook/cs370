Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given the following tutees exist:
      | sid       | first_name | last_name | email                  | privilege | birthdate  |
      | 123456789 | an         | ju        | an.ju@berkeley.edu     | No        | 1992-01-01 |
      | 987654321 | oski       | bear      | oski.bear@berkeley.edu | CS61B     | 1999-09-09 |

    And the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |
      | 2          | CS61B | Sp2019   |

  Scenario: Request for tutoring - No privilege
    Given I am on "an's" tutee page
    When I make a request for "CS61A" with topic "recursive"
    And I select Request Tuttor button
    Then I can see "Tutoring request for class CS61A was successfully created!" message pop up

  Scenario: Request for tutoring - No privilege - Invalid request
    Given I am on "an's" tutee page
    When I make a request for "CS61A" without inputting topic
    And I select Request Tuttor button
    Then I should see "Invalid request"

#  Scenario: Request for tutoring - With privilege
#    Given I am on "oski's" tutee page
#    When I make a request for "CS61A" with topic "recursive"
#    And I choose "90 minutes" from meeting time list
#    And I select Request Tuttor button
#    Then I can see "Tutoring request for class CS61A was successfully created!" message pop up
#
#  Scenario: Request for tutoring - No privilege - Invalid request
#    Given I am on "oski's" tutee page
#    When I make a request for "CS61A" without inputting topic
#    And I choose "120 minutes" from meeting time list
#    And I select Request Tuttor button
#    Then I should see "Invalid request"
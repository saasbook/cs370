Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given the following tutees exist:
      | sid | first_name | last_name | email         | privilege |
      | 10   | an         | ju        | an.ju@cal.ber | CSS       |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    And I am on "an's" tutee page

  Scenario: Request for tutoring
    Given I am on "an's" tutee page
    When I make a request for "CS61A" with topic "recursive"
    Then I can see "Tutoring request for class CS61A was successfully created!" message pop up

  Scenario: Request for tutoring - Invalid request
    Given I am on "an's" tutee page
    When I make a request for "CS61A" without inputting topic
    Then I should see "Invalid request"
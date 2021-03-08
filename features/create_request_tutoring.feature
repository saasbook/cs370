Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given the following tutees exist:
      | sid       | first_name | last_name | email                   | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 123456789 | ann         | ju        | ann.juu@berkeley.edu     | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 987654321 | oskii       | bear      | oskii.bear@berkeley.edu | cs61b     | 1999-09-09 | topsecret | topsecret             | 2019-05-07 05:07:48 |

    And the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |
      | 2          | CS61B | Sp2019   |


  Scenario: Request for tutoring - No privilege
    Given I login as "ann"
    Given I am on "ann's" tutee page
    When I make a request for "CS61A" with topic "recursive"
    And I select Request tutor button
    Then I can see "Tutoring request for class CS61A was successfully created!" message pop up


  Scenario: Request for tutoring - No privilege - Invalid request
    Given I login as "ann"
    Given I am on "ann's" tutee page
    When I make a request for "CS61A" without inputting topic
    And I select Request tutor button
    Then I should see "Invalid request"

  Scenario: Request for tutoring - With privilege
    Given I login as "oskii"
    Given I am on "oskii's" tutee page
    When I make a request for "CS61B" with topic "recursive"
    And I choose "90 minutes" from meeting time list
    And I select Request tutor button
    Then I can see "Tutoring request for class CS61B was successfully created!" message pop up

  Scenario: Request for tutoring - No privilege - Invalid request
    Given I login as "oskii"
    Given I am on "oskii's" tutee page
    When I make a request for "CS61A" without inputting topic
    And  I choose "120 minutes" from meeting time list
    And I select Request tutor button
    Then I should see "Invalid request"

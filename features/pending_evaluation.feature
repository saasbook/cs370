Feature: submit evaluation
  As a tutee
  So that I need to submit evaluation form
  I can fill out the form given

  Background: meetings has been added to the database
    Given the following tutees exist:
      | sid         | first_name | last_name | email              | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 123456789   | an         | ju        | an.ju@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |


    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given the following requests exist:
      | tutee_id | course_id  | subject |
      | 1        | 1          | recursion  |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email          | first_name | last_name|
      | 20 hour TA   | Junior      | a@berkeley.edu | alvin      | a        |

    Given the following evaluations exist:
      | status     | took_place |
      | Pending    | true       |

    Given "an" had a meeting with tutor "alvin" with meeting id "1" request having tutuee id "1" course name "CS61A" and evaluation status "Pending"

  Scenario: Try to click on Evaluation tab
    Given I login as "an"
    And I am on "an's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending

  Scenario: Fill out evaluation form successfully
    Given I login as "an"
    And I am on "an's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending
    When I click on "Pending" link
    Then I should see "Evaluation Form"
    And I fill out the evaluation that didn't happen and submit
    Then I should see "Evaluation form submitted sucessfully!"

  Scenario: Fill out evaluation form successfully
    Given I login as "an"
    And I am on "an's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending
    When I click on "Pending" link
    Then I should see "Evaluation Form"
    And I fill out the evaluation and submit
    Then I should see "Evaluation form submitted sucessfully!"


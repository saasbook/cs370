Feature: submit evaluation
  As a tutee
  So that I need to submit evaluation form
  I can fill out the form given

  Background: meetings has been added to the database
    Given the following tutees exist:
      | sid         | first_name | last_name | email              | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 123456789   | an         | ju        | an.ju@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 123456788   | a         | j        | a.ju@berkeley.edu | No        | 1992-01-11 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 123456788   | b         | j        | b.ju@berkeley.edu | No        | 1992-01-11 | topsecret | topsecret             | 2019-05-07 05:07:48 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |
    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |id|
      |true  | false | false | false | false | false | false | false |40 |
      
    Given the following requests exist:
      | tutee_id | course_id  | subject   |  
      | 1        | 1          | recursion  |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email		      | password   | password_confirmation | confirmed_at         | first_name | last_name | id  | berkeley_classes_id |
      | 20 hour TA   | 3rd         | a@berkeley.edu | password   | password              | 2019-05-07 05:07:48  | alvin      | a         | 50  | 40                  |

#    Given the following evaluations exist:
#      | status     | took_place | hash_id|
#      | Pending    | true       | 123    |

    Given "an" had a meeting with tutor "alvin" with meeting id "1" request having tutee id "1" course name "CS61A" and evaluation status "Pending" feedback "birthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthday" and set time "2019-05-07 05:07:48"
    Given "a" had a meeting with tutor "alvin" with meeting id "2" request having tutee id "2" course name "CS61A" and evaluation status "Pending" feedback "birthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthday" and set time "2030-05-07 05:07:48"
    Given "b" had a meeting with tutor "alvin" with meeting id "3" request having tutee id "3" course name "CS61A" and evaluation status "Pending" feedback "birthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthday" and set time "nil"

  Scenario: Try to click on Evaluation tab
    Given I login as "an"
    And I am on "an's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending
  
  Scenario: Try to fill in before scheduled meeting
    Given I login as "a"
    And I am on "a's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending
    When I click on "Pending" link
    Then I should see "You can only fill in the evaluation form after the scheduled meeting."

  Scenario: Try to fill in before scheduling meeting
    Given I login as "b"
    And I am on "b's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending
    When I click on "Pending" link
    Then I should see "You can only fill in the evaluation form after the scheduled meeting."

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

  Scenario: Fill out evaluation form unsuccessfully
    Given I login as "an"
    And I am on "an's" tutee page
    When I click on "Evaluation" link
    Then I can see my evaluation form with course name CS61A
    And I can see my evaluation form with tutor name alvin
    And I can see my evaluation form with status Pending
    When I click on "Pending" link
    Then I should see "Evaluation Form"
    And I partially fill out the evaluation and submit
    Then I should see "Evaluation Form"
  Scenario: Fill out evaluation form public successfully
    Given I am on the public edit page with feedback "birthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthday"
    Then I should see "Evaluation Form"
    And I fill out the evaluation and submit
    And I should see "Evaluation form submitted sucessfully!"

Feature: see history request
  As a tutee
  I want to know my tutoring history

  Background: meetings has been added to the database
    Given the following tutees exist:
      | sid         | first_name | last_name | email              | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 123456789   | an         | ju        | an.ju@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 123456788   | a          | j        | a.ju@berkeley.edu | No        | 1992-01-11 | topsecret | topsecret             | 2019-05-07 05:07:48 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |
      
    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |id|
      |true  | false | false | false | false | false | false | false |40 |

    Given the following requests exist:
      | tutee_id | course_id  | subject |
      | 1        | 1          | recursion  |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email		      | password   | password_confirmation | confirmed_at         | first_name | last_name | id  | berkeley_classes_id |
      | 20 hour TA   | 3rd         | a@berkeley.edu | password   | password              | 2019-05-07 05:07:48  | alvin      | a         | 1   | 40                   |


    Given "an" had a meeting with tutor "alvin" with meeting id "1" request having tutee id "1" course name "CS61A" and evaluation status "Complete" feedback "birthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthdaybirthday" and set time "nil"

  Scenario: Try to click on history tab given that I have history
    Given I login as "an"
    Given I am on "an's" tutee page
    Then I click on "History" link
    And I can see my history request with first_name "an"
    And I can see my history request with course_name "CS61A"
    And I can see my history request with status evaluation "Complete"

Feature: Set up meting with tutor
  As a tutee
  I want to set up a tutoring meeting
  So that I can meet with my tutor

  Background: There exists a tutee annd courses
    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |id|
      |true  | false | false | false | false | false | false | false |1 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email		            | password  | password_confirmation | confirmed_at        | id | first_name | last_name     | id | berkeley_classes_id |
      | 20 hour TA   | 3rd         | testtutor@berkeley.edu | topsecret | topsecret             | 2019-05-07 05:07:48 | 1  | test       | tutor         | 1  | 1                   |

    Given the following tutees exist:
      | sid        | first_name | last_name | email                    | privilege | birthdate  | password  | password_confirmation | confirmed_at        | id
      | 1234567890 | test       | student   | teststudent@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 | 1

     Given "test" had a meeting with tutor "test" with meeting id "1" request having tutee id "1" course name "CS61A" and evaluation status "Pending" times "2030-12-07 05:07:48,2030-05-07 05:07:48,2030-05-07 05:07:48" and locations "soda,dwinelle,remote"

  Scenario: Set up meeting
    Given I login as "test"
    Given I am on "test's" tutee page
    And I follow "Meeting"
    And I press "Schedule Meeting"
    Then I should see "Your Next Meeting Info"
    Then I should see "Friday 06 at 9:07 PM"
    Then I should see "Soda"


  Scenario: Cancel meeting
    Given I login as "test"
    Given I am on "test's" tutee page
    And I follow "Meeting"
    And I press "Cancel Meeting"
    Then I can see "Your meeting was successfully cancelled" message pop up

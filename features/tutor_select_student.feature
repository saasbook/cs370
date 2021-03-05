Feature: Tutor selects a student

  As a current tutor
  I want see all the students
  So that I can select a student to tutor

  Background: A tutee exists
    Given the following tutees exist:
      | sid         | first_name | last_name | email              | privilege | birthdate  | password  | password_confirmation | confirmed_at        | id|
      | 123456789   | an         | ju        | an.ju@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |0  |
      | 123456788   | a          | j         | a.ju@berkeley.edu  | No        | 1992-01-11 | topsecret | topsecret             | 2019-05-07 05:07:48 |1  |

    Given the following courses exist:
      | course_num | name  | semester     | id |
      | 1          | CS61A | Spring2019   | 0  |
      | 2          | CS61B | Spring2019   | 1  |
      | 3          | CS61C | Spring2019   | 2  |
      | 4          | CS70  | Spring2019   | 3  |
      | 5          | EE16A | Spring2019   | 4  |
      | 6          | CS88  | Spring2019   | 5  |
      | 7          | CS10  | Spring2019   | 6  |
      | 8          | DATA8 | Spring2019   | 7  |



    Given the following requests exist:
      | tutee_id | course_id  | subject    | id |
      | 1        | 7          | recursion  |0   |

    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 | id |
      |true  | true  | true  | true  | true  | true  | true  | true | 19  |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email		         | password   | password_confirmation | confirmed_at         | first_name | last_name | id  | berkeley_classes_id |
      | 20 hour TA   | 3rd         | test@berkeley.edu | password   | password              | 2019-05-07 05:07:48  | test       | t         | 50  | 19                  |


  Scenario: Selecting a Student Succesfully
    Given I am on the home page
    And I go to the tutor page for "test@berkeley.edu"
    And I go to the find students page for "test@berkeley.edu"
    And I should see "a"
    And I follow "CS61A"
    And I press "Select Student"
    Then I should see "There are no students in the queue for CS61A"

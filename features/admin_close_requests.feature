Feature: 
  As an admin
  So that I can have set periods where students can be matched
  I want to be able to close unmatched requests

Background:

    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Sp2019           | Sp2019              |

    Given the following tutees exist:
      | sid       | first_name | last_name | email                   | privilege | birthdate  | password  | password_confirmation | confirmed_at        | id|
      | 123456789 | ann         | ju        | ann.juu@berkeley.edu     | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |  0|
      | 987654321 | oskii       | bear      | oskii.bear@berkeley.edu | cs61b     | 1999-09-09 | topsecret | topsecret             | 2019-05-07 05:07:48 |  1|

    And the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |
      | 2          | CS61B | Sp2019   |

    Given the following requests exist:
      | tutee_id | course_id  | subject    | id |
      | 0        | 1          | recursion  |0   |
      | 1        | 1          | recursion  |1   |

    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 | id |
      |true  | true  | true  | true  | true  | true  | true  | true | 19  |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email		       | password   | password_confirmation |      confirmed_at | first_name | last_name | id  | berkeley_classes_id |
      | 20 hour TA   | 3rd         | test@berkeley.edu | password   | password              | 2019-05-07 05:07:48     | test       | t         | 50  | 19 |

    Given "oskii" had a meeting with tutor "test" with meeting id "1" request having tutuee id "1" course name "CS61A" and evaluation status "Pending" times "2030-12-07 05:07:48,2030-05-07 05:07:48,2030-05-07 05:07:48" and locations "soda,dwinelle,remote"

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    And I press link "Close All Unmatched Requests"

  Scenario: Unmatched Requests are Closed
    Given I login as "ann"
    Given I am on "ann's" tutee page
    When I press link "Request"
    Then I should see "Fill out a request"

  Scenario: Matched Requests are not closed
    Given I login as "oskii"
    Given I am on "oskii's" tutee page
    When I press link "Request"
    Then I should see "Your request has been matched! Please fill out the evaluation form after your meeting."

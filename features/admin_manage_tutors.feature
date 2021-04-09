Feature: Validate Tutors
  As the admin of the course,
  So that random people can't register as tutors,
  I want to be able to manage tutors by email.

  Background: There exists these info
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    Given the following tutees exist:
      | sid       | first_name  | last_name    | email               | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 123456709 | thu         | nguyen       | thuu.ju@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given the following requests exist:
      | tutee_id | course_id | subject   |
      | 1        | 1         | recursion |

    Given the following tutors exist:
      | type_of_tutor | grade_level | email              | first_name | last_name | password  | password_confirmation | confirmed_at |
      | 20 hour TA    | Senior      | oskii@berkeley.edu | ana        | chang     | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 20 hour TA    | Junior      | alexa@berkeley.edu | alexa      | chen      | topsecret | topsecret             | 2019-05-07 05:07:48 |

    Given the following evaluations exist:
      | status     | took_place |
      | Complete   | true       |

    Given "thu" has a meeting with tutor "alexa" meeting id "1" request with tutuee id "1" course name "CS61A" and evaluation status "Complete" knowledge "5" helpful "5" clarity "5"

    Given "thu" has a meeting with tutor "alexa" meeting id "2" request with tutuee id "1" course name "CS61A" and evaluation status "Complete" knowledge "5" helpful "5" clarity "5"

    Given "thu" has a meeting with tutor "alexa" meeting id "3" request with tutuee id "1" course name "CS61A" and evaluation status "Complete" knowledge "4" helpful "4" clarity "4"

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page

  Scenario: Delete both tutors
    When I click on "Manage Tutors" link
    Then I should be on the manage tutors page
    And I can see the tutor name "alexa"
    And I can see the tutor name "ana"
    When I fill in "email" with "alexa@berkeley.edu"
    And I press "Delete Tutor"
    Then I should not see "alexa chen"
    And I can see the tutor name "ana"
    When I fill in "email" with "oskii@berkeley.edu"
    And I press "Delete Tutor"
    Then I should not see "ana chang"

Feature: Update Semester
  As a admin
  I want to update the semester
  So that the semester is updated on every semester

  Background: There exists these info
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    Given the following tutees exist:
      | sid       | first_name | last_name | email              | privilege | birthdate  |
      | 123456789 | an         | ju        | an.ju@berkeley.edu | No        | 1992-01-01 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given the following requests exist:
      | tutee_id | course_id | subject   |
      | 1        | 1         | recursion |

    Given the following tutors exist:
      | type_of_tutor | grade_level | email             | first_name | last_name |
      | 20 hour TA    | Senior      | oski@berkeley.edu | oski       | bear      |

    Given the following meetings exist:
      | tutor_id | request_id | evaluation_id |
      | 1        | 1          | 1             |

    Given the following evaluations exist:
      | status   | took_place | knowledgeable | helpful | clarity | final_comments |
      | Complete | true       | 5             | 5       | 5       | awesome        |

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page

  Scenario: Admin can see rating tutor
    When I click on "Tutor Ratings" link
    Then I should be on the rating tutors page
    And show me the page
#    And I can see the tutor name "oski bear"
#    And I can see the composition score of "5.0"

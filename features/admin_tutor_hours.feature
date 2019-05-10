Feature: Show tutor hours
  As an admin
  So that I need to check how many hours each tutor've done so far
  I can see the table from all tutors with total hours of each one

  Background: all table have been added to the database
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    Given the following tutees exist:
      | sid         | first_name | last_name | email              | privilege | birthdate  |
      | 123456789   | an         | ju        | an.ju@berkeley.edu | No        | 1992-01-01 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given the following requests exist:
      | tutee_id | course_id  | subject    |
      | 1        | 1          | recursion  |
      | 2        | 1          | tree       |
      | 2        | 1          | scheme     |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email            | first_name | last_name|
      | 20 hour TA   | Junior      | a@berkeley.edu   | alvin      | nguyen   |
      | senior TA    | Senior      | dui@berkeley.edu | duy        | le       |
      | junior TA    | Junior      |alex@berkeley.edu | alex       | Zhang    |

    Given the following meetings exist:
      | tutor_id     | request_id  | evaluation_id  |
      | 1            | 1           | 1              |
      | 2            | 2           | 2              |

    Given the following evaluations exist:
      | status     | took_place | hours |
      | Complete   | true       | 3     |
      | Pending    | true       | null  |

  Scenario: Try to click on Tutor Hours tab
    Given I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    And I click on "Tutor Hours" link
    And I can see tutor "alvin" with tutor hours 3
    And I can see tutor "duy" with tutor hours 0
    And I can see tutor "alex" with tutor hours 0

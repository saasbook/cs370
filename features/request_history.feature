Feature: see history request
  As a tutee
  I want to know my tutoring history


  Background: requests have been added to database
    Given the following tutees exist:
      | sid         | first_name | last_name | email              | birthdate  |
      | 198765432   | an         | ju        | an.ju@berkeley.edu | 1992-01-01 |
      | 123124213   | kevin      | ho        | kevin@berkeley.edu | 1992-01-01 |

    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given "an" has a request with course name "CS61A" with subject "sad"
    Given "kevin" has no request

  Scenario: Try to click on history tab given that I have history
    Given I login as "an"
    Given I am on "an's" tutee page
    Then I can see my history request with first_name "an"
    And I can see my history request with course_name "CS61A"
    And I can see my history request with subject "sad"

  Scenario: Try to click on history tab given that I have no history
    Given I login as "kevin"
    Given I am on "kevin's" tutee page
    Then I should not see request of "kevin"

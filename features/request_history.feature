Feature: see history request
  As a tutee
  So that I want to know my tutoring history
  I can see my tutoring history

  Background: requests have been added to database
    Given the following tutees exist:
      | sid | first_name | last_name | email         | privilege |
      | 1   | an         | ju        | an.ju@cal.ber | CSS       |
      | 2   | kevin      | ho        | kevin@cal.ber | CSS       |
    Given the following courses exist:
      | course_num | name  | semester |
      | 1          | CS61A | Sp2019   |

    Given "an" has a request with course name "CS61A" with subject "sad"
    Given "kevin" has no request

  Scenario: Try to click on history tab given that I have history
    Given I am on "an's" tutee page
    When I click on "History" link
    Then I can see my history request with first_name "an"
    And I can see my history request with course_name "CS61A"
    And I can see my history request with subject "sad"

  Scenario: Try to click on history tab given that I have no history
    Given I am on "kevin's" tutee page
    When I click on "History" link
    Then I should not see request of "kevin"
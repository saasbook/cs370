Feature: see history request
  As a tutee
  So that I want to know my tutoring history
  I can see my tutoring history


  Background: requests have been added to database
    Given the following tutees exist:
      | sid | first_name | last_name | email         | privilege
      | 1   | an         | ju        | an.ju@cal.ber | CSS

    Given the following courses exist:
      | course_num | name  | semester
      | 1          | CS61A | Sp2019

    Given the following requests exist:
      | tutee_id | course_id | subject | created_at                 | updated_at
      | 1        | 1         | sad     | 2019-03-22 03:29:37.166982 | 2019-03-22 03:29:37.166982

    And I am on "an's" tutee page

#  Scenario: Try to click on history tab given that I have history
#    Given I am on "an's" tutee page
#    When I click on my history tab
#    Then I can see my tutoring history

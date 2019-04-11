Feature: Create tutoring request
  As a tutee
  I want to create a tutoring request
  So that I can get help with my classes

  Background: There exists a tutee and courses
    Given the following tutees exist:
      |sid      |first_name  |last_name     |email                 |privilege
      |1        |an          |ju            |an.ju@cal.ber         |CSS

    Given the following courses exist:
      |course_num   |name    |semester
      |1            |CS61A   |Sp2019

    And I am on "an's" tutee page

  Scenario: Request for tutoring
    Given I am on "an's" tutee page
    When I make a request for "CS61A" with reason "blah"
    Then






#    When I click on my history tab
#    Then I can see my tutoring history



  #    Given the following requests exist:
#      |tutee_id |course_id  |subject     |created_at                 |updated_at
#      |1        |1          |sad         |2019-03-22 03:29:37.166982 |2019-03-22 03:29:37.166982
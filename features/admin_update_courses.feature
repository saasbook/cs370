Feature: Update Semester
  As a admin
  I want to update the courses
  So that new courses can be added or removed

  Background: There exists an admin
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |
    And the following courses exist:
      | name  | semester   |
      | CS162 | Spring2019 |
      | CS61A | Spring2019 |
      | CS168 | Spring2019 |

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Update Courses"
    Then I should be on the update courses page
    And I can see courses "CS162, CS61A, CS168"

  Scenario: Admin can add courses
    When I make an update for courses to "CS162, CS61A, CS186, CS170"
    Then I can see courses "CS162, CS61A, CS186, CS170"

  Scenario: Admin can remove courses
    When I make an update for courses to "CS162, CS61A"
    Then I can see courses "CS162, CS61A"
    And I can not see course "CS168"

  Scenario: Admin can update courses with duplicates
    When I make an update for courses to "CS162, CS61A, CS186, CS186, CS186, CS186"
    Then I can see courses "CS162, CS61A, CS186"
    And I can see course "CS186" only once

  Scenario: Admin can update courses with relaxed formatting (whitespace, and lowercases)
    When I make an update for courses to "Cs162, CS61A  , CS  186, cs170"
    Then I can see courses "CS162, CS61A, CS186, CS170"

  Scenario: When current semester is updated, previous semesters courses are copied over for admin future ease
    Given I am on the update semester page
    When I make an update for current semester to "Fall 2020"
    And I am on the update courses page
    Then I can see courses "CS162, CS61A, CS168"
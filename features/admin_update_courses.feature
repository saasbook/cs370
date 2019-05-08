Feature: Update Semester
  As a admin
  I want to update the courses
  So that new courses can be added or removed

  Background: There exists an admin
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |
    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page

  Scenario: Admin can update courses
#    When I make an update for courses to"CS162
#  CS169
#  CS170"
  Scenario: Admin can update courses with duplicates


  Scenario: Admin can update courses with relaxed formatting (whitespace, and lowercases)

  Scenario: When current semester is updated, previous semesters courses are copied over for admin future ease

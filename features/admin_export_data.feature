Feature: Export data to CSV
  As an admin
  So that I can manually analyze any data I want to
  I want to be able to download all data in the database

  Background: admin has been added to the database
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |

    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Manage Semester"
    Then I should be on the manage semester page

  Scenario: Download Tutors
    When I select option "Tutors" from "export_table_table"
    Then I press "Export to CSV"
    Then I should get a csv download with the filename "tutors-" date

  Scenario: Download Tutees
    When I select option "Tutees" from "export_table_table"
    Then I press "Export to CSV"
    Then I should get a csv download with the filename "tutees-" date

  Scenario: Download Meetings
    When I select option "Meetings" from "export_table_table"
    Then I press "Export to CSV"
    Then I should get a csv download with the filename "meetings-" date

  Scenario: Download Requests
    When I select option "Requests" from "export_table_table"
    Then I press "Export to CSV"
    Then I should get a csv download with the filename "requests-" date

  Scenario: Download Courses
    When I select option "Courses" from "export_table_table"
    Then I press "Export to CSV"
    Then I should get a csv download with the filename "courses-" date

  Scenario: Download Evaluations
    When I select option "Evaluations" from "export_table_table"
    Then I press "Export to CSV"
    Then I should get a csv download with the filename "evaluations-" date









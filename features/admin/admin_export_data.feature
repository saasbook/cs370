@javascript
Feature: Export data to CSV
  As an admin
  So that I can manually analyze any data I want to
  I want to be able to download all data in the database

  Background: Admin is on Manage Semester page
    When I log in as admin
    Then I should be on the admin home page

  Scenario: Download All Tables
    When I press link "Manage Semester"
    Then I should be on the manage semester page
    When I download "Export as CSV"
    Then the download should have the filename "cs370-"

# Feature unavailable until further progress is made on organizing/indexing ratings across various models
#  Scenario: Download the ratings as a csv
#    When I click on "Tutor Ratings" link
#    Then I should be on the rating tutors page
#    When I download "Export as CSV"
#    Then the download should have the filename "tutor-ratings-"

  Scenario: Download tutor hours as csv
    When I click on "Tutor Hours" link
    Then I can see tutor "Tutor Default" with tutor hours 0.0
    Then I can see tutor "Tutor Two" with tutor hours 9.0
    Then I can see tutor "Tutor Three" with tutor hours 0.0
    When I download "export1"
    Then the download should have the filename "tutor-hours-"

    When I download "export2"
    Then the download should have the filename "demographic-hours-"

    When I download "export3"
    Then the download should have the filename "course-hours-"

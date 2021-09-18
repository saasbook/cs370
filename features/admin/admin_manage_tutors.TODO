Feature: Validate Tutors
  As the admin of the course,
  So that random people can't register as tutors,
  I want to be able to manage tutors by email.

  Background: There exists these info
    Given I log in as admin

@javascript
  Scenario: Delete both tutors
    When I click on "Manage Tutors" link
    Then I should be on the manage tutors page
    And I can see the tutor name "tr1"
    And I can see the tutor name "tr2"

    When I fill in "email" with "tr1@berkeley.edu"
    And I press "Delete Tutor"
    And I confirm popup
    Then I should not see "Tutor One"

    #Fake delete should not inhibit page functionality
    And I can see the tutor name "Tutor Two"
    When I fill in "email" with "tr2@berkeley.edu"
    And I press "Delete Tutor"
    And I dismiss popup
    Then I can see the tutor name "Tutor Two"

    When I fill in "email" with "tr2@berkeley.edu"
    And I press "Delete Tutor"
    And I confirm popup
    Then I should not see "Tutor Two"

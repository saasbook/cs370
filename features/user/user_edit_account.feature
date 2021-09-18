@javascript
Feature: Users can edit their account information

  As a registered user
  I want to change my account information
  So that it can more accurately represent my person

  Scenario: Tutor type changing all properties except email
    Given I log in with email "tr3@berkeley.edu" and password "111111"
    And I press "Edit Account"
    And I change "First Name" to "Bob"
    And I change "Last Name" to "Burgers"
    And I fill in "New Password" with "topsecret"
    And I fill in "New Password Confirmation" with "topsecret"
    And I fill in "user_current_password" with "general_seed_password"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "He/His" from "Pronouns"
    #NOTE: White does not work in these tests because it shows up twice in the dropdown menu.
    And I bootstrap select "Chinese" from "Ethnicity"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    #NOTE: For the purposes of the test, it must choose something other than what's already selected. Not a constraint irl.
    And I bootstrap select "Declared" from "Major"
    And I bootstrap select "EECS" from "Major"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I press "Save Changes"
    Then I should see "Account successfully updated"
    And I should be on the dashboard
    And I should see "Welcome, Bob"
    And I should not see "Welcome, Tutor"


  Scenario: Try to update account with wrong password
    Given I log in with email "tr3@berkeley.edu" and password "111111"
    And I press "Edit Account"
    And I fill in "user_current_password" with "WRONG PASSWORD"
    And I press "Save Changes"
    Then I should see "Current password is invalid"

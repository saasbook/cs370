@javascript
Feature: Tutee can update their account information

  As a current user
  I want to edit my account information
  So that I can ensure my profile is up to date

  Background: User has an acocunt
    Given I log in as "Tutee" "One"
    Then I should be on "One's" tutee page
    Then press link "Edit Info"
    Then I should be on the tutee edit page for "tt1@berkeley.edu"

  Scenario: Update all values successfully
    And I change "First Name" to "Bob"
    And I change "Last Name" to "Burgers"
    And I change "Student ID" to "123456789"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I fill in "tutee_current_password" with "general_seed_password"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "He/His" from "Pronouns"
    #NOTE: White does not work in these tests because it shows up twice in the dropdown menu.
    And I bootstrap select "Chinese" from "Ethnicity"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    #NOTE: For the purposes of the test, it must choose something other than what's already selected. Not a constraint irl.
    And I bootstrap select "Declared" from "Major"
    And I bootstrap select "Other" from "Major"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I press "Save Changes"
    Then I should see "Your account has been updated successfully."
    And I should be on the tutee page for "tt1@berkeley.edu"

  Scenario: Try to update account with wrong password
    And I fill in "tutee_current_password" with "WRONG PASSWORD"
    And I press "Save Changes"
    Then I should see "Current password is invalid"
    #TODO: This needs to change to be tutee edit page, there's a routing issue with devise edit controller.
    And I should be on the tutee page for "tt1@berkeley.edu"

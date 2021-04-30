@javascript
Feature: Tutee can create an account

  As an unregistered Tutee
  I want to create an account
  So that I can request tutoring

  Background:
    Given I am on the login page
    And I want to log in as user type "Tutee"
    And I press link "Register here"
    Then I should be on the tutee create account page

  Scenario: create account successfully
    Then I should be on the tutee create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student ID" with "123456789"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "He/His" from "Pronouns"
    #NOTE: White does not work in these tests because it shows up twice in the dropdown menu.
    And I bootstrap select "Chinese" from "Ethnicity"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    And I bootstrap select "Intended" from "Major"
    And I bootstrap select "Other" from "Major"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I press "Create Account"
    Then I should see "Account was successfully created. Please check your email to authenticate your account"

  Scenario: create account unsuccessfully
    Then I should be on the tutee create account page
    And I fill in "First Name" with "Email"
    And I fill in "Last Name" with "Taken"
    And I fill in "Email" with "tt1@berkeley.edu"
    And I fill in "Student ID" with "123456789"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "He/His" from "Pronouns"
    And I bootstrap select "Korean" from "Ethnicity"
    And I bootstrap select "1" from "Current Term in Attendance"
    And I bootstrap select "Intended" from "Major"
    And I bootstrap select "Other" from "Major"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I press "Create Account"
    Then I should see "Account was not successfully created"

@javascript
Feature: User can create an account

  As an unregistered User
  I want to create an account
  So that I can request or provide tutoring

  Background:
    Given I am on the home page
    And I press link "Sign up"
    Then I should be on the user registration page

  Scenario: create account successfully
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "He/His" from "Pronouns"
    #NOTE: White does not work in these tests because it shows up twice in the dropdown menu.
    And I bootstrap select "Chinese" from "Ethnicity"
    And I bootstrap select "Korean" from "Ethnicity"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    And I bootstrap select "Intended" from "Major"
    And I bootstrap select "Other" from "Major"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I press "Create Account"
    Then I should see "Account was successfully created. Please check your email to authenticate your account"

  Scenario: create account unsuccessfully
    And I fill in "First Name" with "Email"
    And I fill in "Last Name" with "Taken"
    And I fill in "Email" with "tt1@berkeley.edu"
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

@javascript
Feature: Tutor can create an account

  As an unregistered Tutor
  I want to create an account
  So that I can provide tutoring

  Background:
    Given I am on the home page
    And I want to log in as user type "Tutor"
    And I press link "Register here"
    Then I should be on the tutor create account page

  Scenario: create account successfully
    Then I should be on the tutor create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student ID" with "123456789"
    And I bootstrap select "TA (12 hours)" from "Tutor Type"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "Yes" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    And I bootstrap select "Declared" from "Major"
    And I bootstrap select "EECS" from "Major"
    And I press "Create Account"
    Then I should see "Account was successfully created. Please check your email to authenticate your account"

  Scenario: create account unsuccessfully
    Then I should be on the tutor create account page
    And I fill in "First Name" with "Email"
    And I fill in "Last Name" with "Taken"
    And I fill in "Email" with "tr1@berkeley.edu"
    And I fill in "Student ID" with "123456789"
    And I bootstrap select "TA (12 hours)" from "Tutor Type"
    And I fill in "Password" with "topsecret"
    And I fill in "Password Confirmation" with "topsecret"
    And I bootstrap select "Female" from "Gender"
    And I bootstrap select "No" from "DSP Student?"
    And I bootstrap select "Yes" from "Transfer Student?"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    And I bootstrap select "Intended" from "Major"
    And I bootstrap select "Data Science" from "Major"
    And I press "Create Account"
    Then I should see "Account was not successfully created"

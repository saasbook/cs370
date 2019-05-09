Feature: Tutee can create an account

  As an unknown user
  So that I can request a tutor
  I want to create an account

  Background:
    Given I am on the login page
    And I press link "Register here"
    Then I should be on the create account page

  Scenario: creat account successfully
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "Select a role"
    And I press "Student"
    Then I should be on the login page
    And I should see "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."

  Scenario: Try create account with missing first name field
    Given I am on the create account page
    And I fill in "First Name" with ""
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "1 error prohibited this tutee from being saved"
    And I should see "Create Account"


  Scenario: Try create account with missing last name field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with ""
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "1 error prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try create account with digits in first name field
    Given I am on the create account page
    And I fill in "First Name" with "Bob123"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "1 error prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try create account with digits in last name field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers123"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I press "Sign up"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "1 error prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try create account with missing birthdate field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with ""
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "2 errors prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try create account with invalid birthdate format
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "06-19-1992"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I press "Sign up"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "2 errors prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try create account with future birthdate
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "3030-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I press "Sign up"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "1 error prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try to create account with missing sid field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@berkeley.edu"
    And I fill in "Student SID" with ""
    And I press "Sign up"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "3 errors prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try to create an account with non berkeley email
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@gmail.com"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "2 errors prohibited this tutee from being saved"
    And I should see "Create Account"

  Scenario: Try to create an account with empty email field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with ""
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign up"
    Then I should see "3 errors prohibited this tutee from being saved"
    And I should see "Create Account"
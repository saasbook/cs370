Feature: Tutee can create an account

  As an unknown user
  So that I can request a tutor
  I want to create an account

  Background:
    Given I am on the login page
    And I press link "Register here"
    Then I should be on the create account page

  Scenario: create account successfully
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was successfully created. Please check your email to authenticate your account"
    
  Scenario: Try create account with missing first name field
    Given I am on the create account page
    And I fill in "First Name" with ""
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"


  Scenario: Try create account with missing last name field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with ""
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try create account with digits in first name field
    Given I am on the create account page
    And I fill in "First Name" with "Bob123"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try create account with digits in last name field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers123"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try create account with missing birthdate field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with ""
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try create account with invalid birthdate format
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "06-19-1992"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try create account with future birthdate
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "3030-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try to create account with missing sid field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "boburgers@berkeley.edu"
    And I fill in "Student SID" with ""
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try to create an account with non berkeley email
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with "bobburgers@gmail.com"
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"

  Scenario: Try to create an account with empty email field
    Given I am on the create account page
    And I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Birthdate" with "1992-06-19"
    And I fill in "Email" with ""
    And I fill in "Student SID" with "123456789"
    And I fill in "tutee_password" with "topsecret"
    And I fill in "tutee_password_confirmation" with "topsecret"
    And I press "Sign Up"
    Then I should see "Account was not successfully created"
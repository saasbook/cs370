Feature Tutee can create an account

  As an unknown user
  So that I can request a tutor
  I want to create an account

Background:
  Given I am at the login page
  And I click on the "Register here" button
  Then I should be at the create account page

Scenario: creat account successfully
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "information was successfully updated."

Scenario: Try create account with missing first name field
  Given I am on the create account page
  And I input my first name as ""
  And I input my last name as "Burgers"
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "First Name or Last Name left blank."

Scenario: Try create account with missing last name field
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as ""
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "First Name or Last Name left blank."

Scenario: Try create account with digits in first name field
  Given I am on the create account page
  And I input my first name as "Bob123"
  And I input my last name as "Burgers"
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "No digits in first or last name."

Scenario: Try create account with digits in last name field
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers123"
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "No digits in first or last name."

Scenario: Try create account with missing birthdate field
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as ""
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "Invalid date or date format, or empty date field."

Scenario: Try create account with invalid birthdate format
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as "06-19-1992"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "Invalid date or date format, or empty date field."

Scenario: Try create account with future birthdate
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as "3030-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "Invalid date or date format, or empty date field."

Scenario: Try to create account with missing sid field
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@berkeley.edu"
  And I input my sid as ""
  And I click on the "Sign up" button
  Then I should should see "SID field cannot be left empty"

Scenario: Try to create an account with non berkeley email
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as "1992-06-19"
  And I input my email as "bobburgers@gmail.com"
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "Invalid email or missing email, Note: email must with @berkeley.edu."

Scenario: Try to create an account with empty email field
  Given I am on the create account page
  And I input my first name as "Bob"
  And I input my last name as "Burgers"
  And I input my birthdate as "1992-06-19"
  And I input my email as ""
  And I input my sid as "123456789"
  And I click on the "Sign up" button
  Then I should should see "Invalid email or missing email, Note: email must with @berkeley.edu."
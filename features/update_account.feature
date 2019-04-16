Feature Tutee can update an account information

  As a current user
  So that I can ensure my profile is up to date
  I want to edit my account information

Background:
  Given I am at the "Login" page and I have an account
  And I fill username with my email
  Then I should be at the "Dashboard" page
  Then I click on "Edit Info" button Background:

Scenario: update first name successfully
  Given I am on the "Update Information" page
  And I change my first name to "Bobby"
  And I click on the "Save changes" button
  Then I should should see "Account for Bob was successfully created."  Scenario: update an first name successfully

Scenario: update last name successfully
  Given I am on the "Update Information" page
  And I change my last name to "Hotdogs"
  And I click on the "Save changes" button
  Then I should should see "Account for Bob was successfully created."

Scenario: update birthdate successfully
  Given I am on the "Update Information" page
  And I change my birthdate to "1993-06-19"
  And I click on the "Save changes" button
  Then I should should see "Account for Bob was successfully created."

Scenario: update email successfully
  Given I am on the "Update Information" page
  And I change my email to "bobhotdogs@berkeley.edu"
  And I click on the "Save changes" button
  Then I should should see "Account for Bob was successfully created."

Scenario: update sid successfully
  Given I am on the "Update Information" page
  And I change my sid to "987654321"
  And I click on the "Save changes" button
  Then I should should see "Account for Bob was successfully created."

Scenario: Try to update account with missing first name field
  Given I am on the "Update Information" page
  And I change my first name to ""
  And I click on the "Save changes" button
  Then I should should see "First Name or Last Name left blank."

Scenario: Try to update account with missing last name field
  Given I am on the "Update Information" page
  And I change my last name to ""
  And I click on the "Save changes" button
  Then I should should see "First Name or Last Name left blank."

Scenario: Try to update account with account with digits in first name field
  Given I am on the "Update Information" page
  And I change my first name to "Bob123"
  And I click on the "Save changes" button
  Then I should should see "No digits in first or last name."

Scenario: Try to update account with account with digits in last name field
  Given I am on the "Update Information" page
  And I change my last name to "Burgers123"
  And I click on the "Save changes" button
  Then I should should see "No digits in first or last name."

Scenario: Try to update account with missing birthdate field
  Given I am on the "Update Information" page
  And I change my birthdate to ""
  And I click on the "Save changes" button
  Then I should should see "Invalid date or date format, or empty date field."

Scenario: Try to update account with invalid birthdate format
  Given I am on the "Update Information" page
  And I change my birthdate to "06-19-1992"
  And I click on the "Save changes" button
  Then I should should see "Invalid date or date format, or empty date field."

Scenario: Try to update account with future birthdate
  Given I am on the "Update Information" page
  And I change my birthdate to "3030-06-19"
  And I click on the "Save changes" button
  Then I should should see "Invalid date or date format, or empty date field."


Scenario: Try to update account with missing sid field
  Given I am on the "Update Information" page
  And I change my sid to ""
  And I click on the "Save changes" button
  Then I should should see "SID field cannot be left empty"

Scenario: Try to update account with non berkeley email
  Given I am on the "Update Information" page
  And I change my email to "bobburgers@gmail.com"
  And I click on the "Save changes" button
  Then I should should see "Invalid email or missing email, Note: email must with @berkeley.edu."

Scenario: Try to update account with empty email field
  Given I am on the "Update Information" page
  And I change my email to ""
  And I click on the "Save changes" button
  Then I should should see "Invalid email or missing email, Note: email must with @berkeley.edu."

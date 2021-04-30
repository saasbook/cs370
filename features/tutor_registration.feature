Feature: Create a new Tutor

  As an unregistered tutor
  I want to create an account
  So that I can provide tutoring

  Scenario: create a new tutor called Emma
    Given I am on the home page
    And I press "Tutor"
    And I follow "Register here"
    And I fill in "First name" with "Emma"
    And I fill in "Last name" with "e"
    And I fill in "Email" with "e@berkeley.edu"
    And I fill in "Birthday" with "01/01/1997"
    And "2nd" is selected for "Years in School"
    And I fill in "Password (6 char. minimum)" with "password"
    And I fill in "Confirm Password" with "password"
    And "Female" is selected for "Gender"
    And I fill in "Major" with "Computer Science"
    And "No" is selected for "Are you a transfer student?"
    And "No" is selected for "Are you a DSP student?"
    And "CSM (8-12 hours)" is selected for "Type of tutor"
    And I fill in "Sid" with "1234567890"
    And I check "classes[CS61A]"
    And I press "Create New Tutor"
    Then I should see "Account was successfully created. Please check your email to authenticate your account"
    And I should not see "CS61B"
    And I should not see "CS61C"
    And I should not see "CS70"
    And I should not see "EE16A"
    And I should not see "CS88"
    And I should not see "CS10"
    And I should not see "DATA8"

  Scenario: I fail to create a tutor
    Given I am on the home page
    And I press "Tutor"
    And I follow "Register here"
    And I press "Create New Tutor"
    Then I should not see "Tutor was not successfully created."

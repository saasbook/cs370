Feature: Create a new Tutor
  As a first time tutor
  So that I can create an account
  I want to input all the relevant fields: name, tutor type, and personal details like email
  Background: tutors in database

    Given the following tutors exist:
      | type_of_tutor| grade_level | email          | first_name | last_name|
      | 20 hour TA   | Junior      | a@berkeley.edu | alvin      | a        |
      | 8 hour tutor | Senior      | b@berkeley.edu | divinee    | b        |
      | AI           | Sophomore   | c@berkeley.edu | Gloria     | c        |
      | 10 hour TA   | Junior      | d@berkeley.edu | AJ         | d        |


    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |
      |true  | false | false | false | false | false | false | false |
      |true  | false | false | false | false | false | false | false |
      |true  | false | false | false | false | false | false | false |
      |true  | false | false | false | false | false | false | false |
      

  Scenario: create a new tutor called Laura
    Given I am on the home page
    And I follow "New Tutor"
    And "CSM (8-12 hour)" is selected for "Type of tutor"
    And "Sophomore" is selected for "Grade level"
    And I fill in "Email" with "e@berkeley.edu"
    And I fill in "First name" with "Laura"
    And I fill in "Last name" with "e"
    And I press "Create New Tutor"
    Then I should see "Laura e was successfully created."

  Scenario: I fail to create a tutor
    Given I am on the home page
    And I follow "New Tutor"
    And "CSM (8-12 hour)" is selected for "Type of tutor"
    And "Sophomore" is selected for "Grade level"
    And I fill in "Email" with ""
    And I fill in "First name" with ""
    And I fill in "Last name" with ""
    And I press "Create New Tutor"
    Then I should see "Tutor was not successfully created."
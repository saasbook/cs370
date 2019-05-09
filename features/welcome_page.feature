Feature: logging into account
  As a tutor
  So that I view my user account
  I want to input my email

  Background: tutors in database
    Given the following berkeley_classes exist:
      |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |id|
      |true  | false | false | false | false | false | false | false |40 |
      |true  | false | false | false | false | false | false | false |41 |
      |true  | false | false | false | false | false | false | false |42 |
      |true  | false | false | false | false | false | false | false |43 |

    Given the following tutors exist:
      | type_of_tutor| grade_level | email		    | first_name | last_name |  id| berkeley_classes_id |
      | 20 hour TA   | 3rd         | a@berkeley.edu | alvin      | a         |50   |40                   |
      | 8 hour tutor | 4th         | b@berkeley.edu | divinee    | b         |51   |41                   |
      | AI           | 2nd         | c@berkeley.edu | Gloria     | c         |52   |42                   |
      | 10 hour TA   | 3rd         | d@berkeley.edu | AJ         | d         |53   |43                   |




  Scenario: login to my account successfully
    Given I am on the welcome page
    And I press "Tutor Page"
    And I fill in "Username:" with "a@berkeley.edu"
    And I press "Login"
    Then I should see "Welcome back"

  Scenario: login to my account unsuccessfully
    Given I am on the welcome page
    And I press "Tutor Page"
    And I fill in "Username:" with "e@berkeley.edu"
    And I press "Login"
    Then I should see "Email 'e@berkeley.edu' does not exist"
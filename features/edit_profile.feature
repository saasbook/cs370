Feature: Edit tutor profile

	As a tutor
	So that my profile reflects my actual preferences
	I want to update my user profile

	Background: populate database with tutor

		Given the following tutors exist:
		| type_of_tutor| grade_level | email		 | first_name | last_name |
	    | AI   		   | Senior      | test@test.edu | testyBoi   | lastName  |

	    Given the following berkeley_classes exist:
	    |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |
	    |false | false | false | false | false | false | false | false |

	Scenario: tutor can update preferred classes
   		Given I am on the home page
		And I follow "Edit"
		When I check "CS61A"
		And I check "CS61B"
		And I check "CS61C"
		And I check "DATA8"
		And I press "Submit"
		Then I should see "CS61A"
		And I should see "CS61B"
		And I should see "CS61C"
		And I should see "DATA8"
		And I should not see "CS70"
		And I should not see "EE16A"
		And I should not see "CS88"
		And I should not see "CS10"


	Scenario: tutor can not update email if provided email is invalid
		Given I am on the home page
		And I follow "Edit"
		When I fill in "Email" with "not valid email"
		And I press "Submit"
		Then I should see "test@test.edu"
		And I should not see "not valid email"

	Scenario: tutor can update email
	  Given I am on the home page
		And I follow "Edit"
		When I fill in "Email" with "valid@valid.com"
		And I press "Submit"
		Then I should see "valid@valid.com"
		And I should not see "test@test.edu"

	Scenario: tutor can not update year if provided year is invalid
		Given I am on the home page
		And I follow "Edit"
		When I fill in "Year" with "8th grade"
		And I press "Submit"
		Then I should see "Senior"
		And I should not see "8th grade"

	Scenario: tutor update year
		Given I am on the home page
		And I follow "Edit"
		When I fill in "Year" with "Freshman"
		And I press "Submit"
		Then I should see "Freshman"
		And I should not see "Senior"

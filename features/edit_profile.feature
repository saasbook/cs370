Feature: Edit tutor profile

	As a tutor
	So that my profile reflects my actual preferences
	I want to update my user profile

	Background: populate database with tutor

	    Given the following berkeley_classes exist:
	    |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 | id |
	    |true  | true | false | false | false | false | false | false | 0   |

		Given the following tutors exist:
		| type_of_tutor| grade_level | email		 | first_name | last_name |  id| berkeley_classes_id |
	    | AI   		   | 4th      | test@berkeley.edu | testyBoi   | lastName  | 0 | 0                |

	    

	Scenario: tutor can update preferred classes
   		Given I am on the home page
		And I go to "tutor index page"
		And I go to the tutor update page for "test@berkeley.edu"
		And I uncheck "CS61B"
		And I check "CS61C"
		And I check "DATA8"
		And I press "Update"
		And I should see "CS61A"
		And I should see "CS61C"
		And I should see "DATA8"
		And I should not see "CS61B"
		And I should not see "CS70"	
		And I should not see "EE16A"		
		And I should not see "CS88"		
		And I should not see "CS70"
		And I should not see "EE16A"
		And I should not see "CS88"
		And I should not see "CS10"

	Scenario: tutor can update email
	  Given I am on the home page
		And I go to "tutor index page"
		And I follow "Edit"
		When I fill in "Email" with "valid@berkeley.edu"
		And I press "Update"
		Then I should see "valid@berkeley.edu"
		And I should not see "test@berkeley.edu"

	Scenario: tutor can not update email if provided email is invalid
		Given I am on the home page
		And I go to "tutor index page"
		And I follow "Edit"
		When I fill in "Email" with "not valid email"
		And I press "Update"


	Scenario: tutor update year
		Given I am on the home page
		And I go to "tutor index page"
		And I follow "Edit"
		When I select "1st" from "Year"
		And I press "Update"
		Then I should see "1st"
		And I should not see "4th"



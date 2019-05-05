Feature: Edit tutor profile

	As a tutor
	So that my profile reflects my actual preferences
	I want to update my user profile

	Background: populate database with tutor

		Given the following tutors exist:
		| type_of_tutor| grade_level | email		 | first_name | last_name |
	    | AI   		   | Senior      | test@berkeley.edu | testyBoi   | lastName  |

	    Given the following berkeley_classes exist:
	    |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 |
	    |true  | true | false | false | false | false | false | false |

		Given the following tutors exist:
		| type_of_tutor| grade_level | email		 | first_name | last_name | 
	    | AI   		   | Senior      | test@berkeley.edu | testyBoi   | lastName  |

	    

	Scenario: tutor can update preferred classes
   		Given I am on the home page
		And I go to "tutor index page"
		And I follow "tutors/0/edit"
		And I uncheck "CS61B"
		And I check "CS61C"
		And I check "DATA8"
		And I press "Submit"
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
		And I press "Submit"
		Then I should see "valid@berkeley.edu"
		And I should not see "test@berkeley.edu"

	Scenario: tutor can not update email if provided email is invalid
		Given I am on the home page
<<<<<<< HEAD
=======
		And I go to "tutor index page"
>>>>>>> ab92550e5e11203502594f4d15c29e36c551645a
		And I follow "Edit"
		When I fill in "Email" with "not valid email"
		And I press "Submit"
		Then the "Email" field within "div#email.row" should contain "test@berkeley.edu"

	Scenario: tutor update year
		Given I am on the home page
		And I go to "tutor index page"
		And I follow "Edit"
		When I select "Freshmen" from "Year" 
		And I press "Submit"
		Then I should see "Freshmen"
		And I should not see "Senior"



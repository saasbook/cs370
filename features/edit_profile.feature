Feature: Edit tutor profile

	As a tutor
	So that my profile reflects my actual preferences
	I want to update my user profile

	Background: populate database with tutor

	    Given the following berkeley_classes exist:
	    |CS61A | CS61B | CS61C | CS70  | EE16A | CS88  | CS10  | DATA8 | id |
	    |true  | true | false | false | false | false | false | false | 19   |

		Given the following tutors exist:
		| type_of_tutor| grade_level | email		 | first_name | last_name |  id| berkeley_classes_id | password  | password_confirmation | confirmed_at |
	    | AI   		   | 4th      | test2@berkeley.edu | testyBoi   | lastName  | 19 | 19                | topsecret | topsecret             | 2019-05-07 05:07:48 |

	    

	Scenario: tutor can update preferred classes
   		Given I am on the home page
    	And I press "Tutor Page"
    	And I fill in "username" with "test2@berkeley.edu"
    	And I fill in "password" with "topsecret"
    	And I press "Log in"
		And I go to the tutor update page for "test2@berkeley.edu"
		And I uncheck "CS61B"
		And I check "CS61C"
		And I check "DATA8"
		And I press "Update"
		Then I should be on the tutor page for "test2@berkeley.edu"
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

	Scenario: tutor update year
		Given I am on the home page
		And I press "Tutor Page"
    	And I fill in "username" with "test2@berkeley.edu"
    	And I fill in "password" with "topsecret"
    	And I press "Log in"
		And I go to the tutor update page for "test2@berkeley.edu"
		When I select "1st" from "Year"
		And I press "Update"
		Then I should see "1st"
		And I should not see "4th"

	Scenario: clear student classes
		Given I am on the home page
		And I press "Tutor Page"
    	And I fill in "username" with "test2@berkeley.edu"
    	And I fill in "password" with "topsecret"
    	And I press "Log in"
		And I go to the tutor update page for "test2@berkeley.edu"
		When I uncheck "CS61A"
		When I uncheck "CS61B"
		And I press "Update"
		Then I should see "Preferred Classes cannot be blank."



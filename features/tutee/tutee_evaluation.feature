@javascript
Feature: Fill out Evaluation
  As a tutee
  I want to fill out my evaluation form
  So that I can make another request

  Background: There exists a tutee, a tutor, and corresponding request, meeting, evaluation, and question objects
    #TODO: for some reason, these custom files break the website. more debugging necessary, but otherwise this feature is like a catch all, if it works, everything works.
    #need to come back for improvements when using FactoryBot.
    #Given the following tutees exist:
    #| id | sid        | first_name | last_name | email                        | gender             |pronoun    |  ethnicity          |major                    |dsp  |transfer|term| password  | password_confirmation | confirmed_at             |
    #| 42 | 031110     | Tutee      | Pending   | tutee_pending@berkeley.edu   | Prefer not to say  |They/Their |  Prefer not to say  |Intended Computer Science|false|false   |  2 | 111111    | 111111                | 2021-05-07 05:07:48 -0700|
    #Given the following tutors exist:
    #| id  | sid    | first_name | last_name | email                        |type_of_tutor | gender             |major                    |dsp  |transfer|term| password  | password_confirmation | confirmed_at             |
    #| 370 | 1234567| Tutor      | Pending   | tutor_pending@berkeley.edu   | TA (12 hours)| Prefer not to say  |Declared Computer Science|false|false   |  2 | 111111    | 111111                | 2021-05-07 05:07:48 -0700|
    #Given the following requests exist:
    #| id | tutee_id | course     | meeting_length | subject      | status |
    #| 50 | 42       | CS61A      | 2.0            | Env diagrams | matched|
    #Given the following meetings exist:
    #| tutor_id | tutee_id | request_id | evaluation_id | set_time                  | set_location | is_scheduled | is_done |
    #| 370      | 42       | 50         |               | 2021-05-15 19:55:00 -0700 | Moffitt      | true         | false   |

    #Given I am on the homepage
    #And byebug
    #Given I log in as "Tutor" "Pending"
    #Then I click on the element with id "row_0"
    #And I press link "Finish Meeting"
    #And I confirm popup
    #Then I should see "Your meeting was successfully finished."
    #And I press "Log Out"

    Given I log in as "Tutee" "Three"
    And I follow "Request"
    And I select "CS61A" from "request_course"
    And I fill in "request_subject" with "Environment Diagrams big sadge"
    And I select "2 hours" from "request_meeting_length"
    And I press "Request Tutor"
    And I press link "Log Out"

    Given I log in as "Tutor" "Three"
    And I follow "Find Tutees"
    And I follow "CS61A"
    And I click on the element with id "row_0"
    And I press "Send Invite"

    Given I click on the element with id "row_0"
    And I fill date "meeting_date" with "12/04/12"
    And I fill time "meeting_time" with "08:30AM"
    And I fill in "meeting_location" with "Moffitt"
    And I press "Confirm Meeting"

    Then I click on the element with id "row_0"
    And I press link "Finish Meeting"
    And I confirm popup
    Then I should see "Your meeting was successfully finished."
    And I press "Log Out"
    And I log in as "Tutee" "Three"


  Scenario: Request for Tutoring for Student with Priority
    Then I should be on "Three's" tutee page
    When I follow "Request"
    Then I should see "Your request has been matched! Please fill out the evaluation form after your meeting."
    And I should not see "Please pick a course:"

    When I follow "Meeting"
    Then I should see "You have no scheduled meetings."

    When I follow "Evaluation"
    Then I should see "Environment Diagrams big sadge"
    And I should see "CS61A"
    And I should see "Pending"

    When I follow "Pending"
    Then I should see "What course did you receive tutoring in?"
    And I should see "How many hours of tutoring did you receive?"
    #This content is dependent on seeds.rb. If this is breaking, that may be why.
    And I should see "What did you like about how your tutor covered the material?"
    And I should see "What is the best thing that your tutor did?"
    And I should see "What is something your tutor could work to improve?"
    And I should see "How knowledgeable was your tutor?"
    And I should see "How supportive was your tutor?"
    And I should see "Any other concerns?"

    When I select "CS61A" from "course"
    #TODO: test bootstrap-slider, but for now user testing is enough, few to no edge cases here.
    And I fill in "response_1" with "This is a very long text box whose idea was it to make it a minimum of 50 characters I mean really"
    And I fill in "response_2" with "Well they did some stuff okay but honestly giving me food was the best part"
    And I fill in "response_3" with "They should probably not be gone for half the meeting getting food though"
    #Leaving "Any other concerns blank, because it should be optional"
    And I press "Submit Evaluation"
    Then I should be on "Three's" tutee page

    When I follow "Evaluation"
    Then I should see "You have no evaluations pending."

    When I follow "Request"
    Then I should see "Please pick a course:"
    And I should see "What topics would you like to cover?"
    And I should not see "Your request has been matched! Please fill out the evaluation form after your meeting."

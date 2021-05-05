@javascript
Feature: Fill out Evaluation
  As a tutee
  I want to fill out my evaluation form
  So that I can make another request

  Background: There exists a tutee, a tutor, and corresponding request, meeting, evaluation, and question objects
    Given the following tutees exist:
    | id | sid        | first_name | last_name | email                        | gender             |pronoun    |  ethnicity          |major                    |dsp  |transfer|term| password  | password_confirmation | confirmed_at             |
    | 42 | 031110     | Tutee      | Pending   | tutee_pending@berkeley.edu   | Prefer not to say  |They/Their |  Prefer not to say  |Intended Computer Science|false|false   |  2 | topsecret | topsecret             | 2021-05-07 05:07:48 -0700|
    Given the following tutors exist:
    | id  | sid    | first_name | last_name | email                        | gender             |major                    |dsp  |transfer|term| password  | password_confirmation | confirmed_at             |
    | 370 | 1234567| Tutor      | Pending   | tutor_pending@berkeley.edu   | Prefer not to say  |Declared Computer Science|false|false   |  2 | topsecret | topsecret             | 2021-05-07 05:07:48 -0700|
    Given the following requests exist:
    | id | tutee_id | course     | meeting_length | subject      | status |
    | 50 | 42       | CS61A      | 2.0            | Env diagrams | matched|
    Given the following meetings exist:
    | tutor_id | tutee_id | request_id | evaluation_id | set_time                  | set_location | is_scheduled | is_done|
    | 370      | 42       | 50         |               | 2021-05-05 19:55:00 -0700 | Moffitt      | true         | false   |
    Given I log in as "Tutor" "Pending"
    And I somehow mark this meeting as finished so it autogenerates all the question templates lord please help me


  Scenario: Request for Tutoring for Student with Priority
    Then I should be on "Three's" tutee page
    When I follow link "Request"
    Then I should see "Create a Request"
    And I should see "Please pick a course:"
    And I should see "What topics would you like to cover?"
    And I should see "Please select how long you would like to meet for:"
    When I select "CS61A" from "request_course"
    And I fill in "request_subject" with "Environment Diagrams big sadge"
    And I select "2 hours" from "request_meeting_length"
    And I press "Request Tutor"
    Then I should see "Tutoring request for class CS61A was successfully created!"
    And I should be on "Three's" tutee page

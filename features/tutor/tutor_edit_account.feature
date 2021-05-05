@javascript
Feature: Tutors can edit their account information

  As a registered tutor
  I want to change my account information
  So that it can more accurately represent my person

  Background:
    Given I log in as "Tutor" "Three"

  Scenario: Change every property
    When I press "Edit Account"
    Then I should see "Account Info"
    And I should see "Demographic Info"

    And "tutor_first_name" should contain "Tutor"
    And "tutor_last_name" should contain "Three"
    #email not allowed to be updated
    And "tutor_sid" should contain "3333333"
    And bootstrap dropdown "tutor_type_of_tutor" should contain "Academic Intern (36 hours)"
    And bootstrap dropdown "tutor_gender" should contain "Non-Binary"
    And bootstrap dropdown "tutor_dsp" should contain "Yes"
    And bootstrap dropdown "tutor_transfer" should contain "Yes"
    And bootstrap dropdown "tutor_term" should contain "6"
    And bootstrap dropdown "for major tutor_major" should contain "Intended, Other"

    When I fill in "First Name" with "Bob"
    And I fill in "Last Name" with "Burgers"
    And I fill in "Student ID" with "123456789"
    And I bootstrap select "CSM (8-10 hours)" from "Tutor Type"
    And I bootstrap select "Male" from "Gender"
    And I bootstrap select "No" from "DSP Student?"
    And I bootstrap select "No" from "Transfer Student?"
    And I bootstrap select "9 or higher" from "Current Term in Attendance"
    And I bootstrap select "Declared" from "Major"
    And I bootstrap select "EECS" from "Major"
    And I press "Confirm Changes"

    Then I should see "Changes saved"

    When I press "Edit Account"
    Then "tutor_first_name" should contain "Bob"
    And "tutor_last_name" should contain "Burgers"
    #email not allowed to be updated
    And "tutor_sid" should contain "123456789"
    And bootstrap dropdown "tutor_type_of_tutor" should contain "CSM (8-10 hours)"
    And bootstrap dropdown "tutor_gender" should contain "Male"
    And bootstrap dropdown "tutor_dsp" should contain "No"
    And bootstrap dropdown "tutor_transfer" should contain "No"
    And bootstrap dropdown "tutor_term" should contain "9 or higher"
    And bootstrap dropdown "for major tutor_major" should contain "Declared, EECS"

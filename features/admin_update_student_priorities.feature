Feature: Update Student Priorities
  As a admin
  I want to update the current students priorities
  So that students cant fake a higher priority and I can increase students priority levels.

  Background: There exists an admin
    Given the following admins exist:
      | id | password            | current_semester | statistics_semester |
      | 1  | secureAdminPassword | Spring2019       | Spring2019          |
    And the following tutees exist:
      | sid       | first_name | last_name | email               | privilege | birthdate  | password  | password_confirmation | confirmed_at        |
      | 1111111   | an         | ju        | an.ju1@berkeley.edu | No        | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 2222222   | an         | ju        | an.ju2@berkeley.edu | cs61a     | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 3333333   | an         | ju        | an.ju3@berkeley.edu | cs61b     | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 4444444   | an         | ju        | an.ju4@berkeley.edu | cs61c     | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
      | 5555555   | an         | ju        | an.ju5@berkeley.edu | cs70      | 1992-01-01 | topsecret | topsecret             | 2019-05-07 05:07:48 |
    And I am on the admin landing page
    When I fill in "password" with "secureAdminPassword"
    And press "Login"
    Then I should be on the admin home page
    When I press link "Update Priorities"
    Then I should be on the update priorities page
    And I can see sids "2222222, 3333333, 4444444, 5555555"
    And I can not see sid "1111111"

  Scenario: Admin can add CS61A scholars
    When I make an update for CS61A scholars to "1111111, 2222222"
    Then I can see sids "1111111, 2222222"


  Scenario: Admin can add CS61B scholars
    When I make an update for CS61B scholars to "1111111, 3333333"
    Then I can see sids "1111111, 3333333"

  Scenario: Admin can add CS61C scholars
    When I make an update for CS61C scholars to "1111111, 4444444"
    Then I can see sids "1111111, 4444444"

  Scenario: Admin can add CS70 scholars
    When I make an update for CS70 scholars to "1111111, 5555555"
    Then I can see sids "1111111, 5555555"

  Scenario: Admin can remove CS61A scholars
    When I make an update for CS61A scholars to "No sids"
    And I can not see sid "2222222"


  Scenario: Admin can remove CS61B scholars
    When I make an update for CS61B scholars to "No sids"
    And I can not see sid "3333333"

  Scenario: Admin can remove CS61C scholars
    When I make an update for CS61C scholars to "No sids"
    And I can not see sid "4444444"

  Scenario: Admin can remove CS70 scholars
    When I make an update for CS70 scholars to "No sidss"
    And I can not see sid "5555555"
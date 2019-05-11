[![Build Status](https://travis-ci.org/freddycervantes/cs370.svg?branch=master)](https://travis-ci.org/freddycervantes/cs370)
[![Maintainability](https://api.codeclimate.com/v1/badges/292d65b74ef218166235/maintainability)](https://codeclimate.com/github/freddycervantes/cs370/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/292d65b74ef218166235/test_coverage)](https://codeclimate.com/github/freddycervantes/cs370/test_coverage)

# README
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

### How to run admin page:
#### Run normal rails initalization such as `bundle install`, `rake db:setup` `rake db:seed`
#### Then need to set a local admin along with admin semesters by running:
`rails c`
followed by 
`Admin.create(:password => "whatever_password_you_want", :current_semester => "Spring2019", :statistics_semester => "Spring2019")`


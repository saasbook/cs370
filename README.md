## CS370 

[![Build Status](https://travis-ci.org/freddycervantes/cs370.svg?branch=master)](https://travis-ci.org/freddycervantes/cs370)
[![Maintainability](https://api.codeclimate.com/v1/badges/292d65b74ef218166235/maintainability)](https://codeclimate.com/github/freddycervantes/cs370/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/292d65b74ef218166235/test_coverage)](https://codeclimate.com/github/freddycervantes/cs370/test_coverage)

Live app: https://cs370-tutoring.herokuapp.com/

Description: [add something here]
### Features

### Setting Up and Testing
Run the following command in CS370 directory:
```
bundle install --without production
```
This will download any files along with gems in order to make the app run properly.

```
rails db:reset
rails db:migrate
rails server
```
This will launch the server.
* You may need to set up admin credential locally first in order to access admin page.
Do the following:
```
rails c
````
This opens the Rails development enviroment. For example:
```
Running via Spring preloader in process 89006
Loading development environment (Rails 5.2.3)
2.5.3 :001 > 
```
Now, you will have to initialize an Admin object by the following line:
```
Admin.create(:password => "whatever_password_you_want", :current_semester => "Spring2019", :statistics_semester => "Spring2019")
```
Lastly, in order to view coverage and run tests. Do:
```
cucumber
```
and/or
```
rspec
```

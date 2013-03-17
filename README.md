## DOCUMENTION AND SETUP INSTRUCTIONS ARE STILL IN PROGRESS

## THE INSTRUCTIONS CURRENTLY DO NOT GET THE APP WORKING

## Alpha

**This is still experimental but has been working for my personal projects.**

Alpha is a starting point for faster prototyping of Rails applications, web service APIs, and / or Ember.js applications, and automatically deploying them to Heroku. It is meant to serve as a rapid prototyping framework, as well as an example application for configuring and using common Rails related technologies.

## Contents

* [Technologies](#technologies)
* [Development Environment](#development-environment)
* [Installation Instructions](#installation-instructions)
* [Development](#development)
* [Testing](#testing)
* [Configuring the Application](#configuring-the-application)
* [Deploying to Heroku](#deploying-to-heroku)
* [Configuring Your Production Environment](#configuring-your-production-environment)
* [TODO](#todo)
* [Miscellaneous](#miscellaneous)
* [License](#license)

## Technologies

Alpha comes packaged and setup to quickly start using the following technologies:

### Frontend
* [Haml](https://github.com/haml/haml), [Sass](https://github.com/nex3/sass), & [Compass](https://github.com/Compass/compass-rails)
* [Twitter Boostrap](https://github.com/vwall/compass-twitter-bootstrap)
* [Font Awesome](https://github.com/bokmann/font-awesome-rails)
* [Modernizr](https://github.com/russfrisch/modernizr-rails)
* [jQuery](http://jquery.com/)
* [Ember](http://emberjs.com/) & [Ember Data](https://github.com/emberjs/data)
* [Handlebars](https://github.com/wycats/handlebars.js)

### Backend
* [Ruby](http://www.ruby-lang.org/en/) 1.9.3
* [Rails](http://rubyonrails.org/) 3.2
* [Devise](https://github.com/plataformatec/devise)
* [CanCan](https://github.com/ryanb/cancan)
* [Omniauth](https://github.com/intridea/omniauth), with integrations for:
	* [Facebook](https://github.com/mkdynamic/omniauth-facebook)
	* [Twitter](https://github.com/arunagw/omniauth-twitter)
	* [Github](https://github.com/intridea/omniauth-github)
	* [LinkedIn](https://github.com/skorks/omniauth-linkedin)
* [Mongoid](https://github.com/mongoid/mongoid)
* [Unicorn](http://unicorn.bogomips.org/)
* [Foreman](https://github.com/ddollar/foreman)
* [Sidekiq](https://github.com/mperham/sidekiq)

### API
* [ActiveModel Serializers](https://github.com/rails-api/active_model_serializers)
* [Rabl](https://github.com/nesquena/rabl)
* Error Handling
* Authentication
* Authorization
* Rate Limiting

### Development & Testing
* [RSpec](http://rspec.info/)
* [FactoryGirl](https://github.com/thoughtbot/factory_girl)
* [BetterErrors](https://github.com/charliesome/better_errors)
* [Pry](https://github.com/pry/pry)
* [Guard](https://github.com/guard/guard)
* [Spork](https://github.com/sporkrb/spork)
* [Jasmine](https://github.com/pivotal/jasmine)
* [SimpleCov](https://github.com/colszowka/simplecov)
* [Rails Footnotes](https://github.com/josevalim/rails-footnotes)

### Production
* Automated provisioning on Heroku
* Worker process running Sidekiq jobs (optional)
* [OpenRedis](https://addons.heroku.com/openredis) (optional)
* [MongoLab](https://addons.heroku.com/mongolab)
* [Logentries](https://addons.heroku.com/logentries)
* [NewRelic](https://addons.heroku.com/newrelic)
* [Mandrill](https://addons.heroku.com/mandrill)
* [Mailchimp](http://mailchimp.com/) (optional)
* [Exceptional](https://addons.heroku.com/exceptional) (optional)
* [S3 / Asset Sync](https://github.com/rumblelabs/asset_sync) (optional)
* [Stripe](https://stripe.com/) (coming soon)

All Heroku services and addons use the free tiers, allowing you to start hosting this app at no cost. Optionally, you can add a worker to start using Sidekiq for background job processing, or Exceptional for error handling, but these are not available for free and are not provisioned by default. Please see Configuring Your Production Environment for more information.

## Development Environment

Alpha has been tested on Mac OS X and Linux/Ubuntu. If you are using another operating system, installation may not be straight forward and I won't be able to help in any way.

I recommend that you use [RVM](https://rvm.io) for managing Ruby versions and gems. Instructions for installing RVM can be found at [https://rvm.io/rvm/install/](https://rvm.io/rvm/install/).

Other prerequisites include:

* An internet connection is **always** required for development
* [Git](http://git-scm.com/downloads)
* [Bundler](http://gembundler.com/#getting-started)
* A Heroku account and API key

All of these should be installed and configured on your system before working with the application.

It is not required that you install any data stores such as MongoDB or Redis, as **ALPHA USES THE SAME DATABASES IN PRODUCTION AND DEVELOPMENT**. This is rarely a suitable setup for any professional development environment, but can greatly increase productivity in a rapid prototyping situation (such as a hackathon). Alpha uses cloud-based versions of MongoDB and Redis called MongoLab and Redis To Go, building off of and saving to your production environment databases from your development environment. It is recommended that you install local versions of MongoDB and Redis though, and are required to run any of the tests.

The additional prerequisites for running the test suite include:

### MongoDB

Instructions for installing MongoDB are available at [http://docs.mongodb.org/manual/installation/](http://docs.mongodb.org/manual/installation/).

### Redis

### PhantomJS

In order to do any javascript testing with [guard-jasmine](https://github.com/netzpirat/guard-jasmine) or [capybara](https://github.com/jnicklas/capybara), you will also need [PhantomJS](http://phantomjs.org/) installed. Installation instructions are available in the guard-jasmine readme: [https://github.com/netzpirat/guard-jasmine#phantomjs](https://github.com/netzpirat/guard-jasmine#phantomjs). For more information on testing with jasmine, see [http://railscasts.com/episodes/261-testing-javascript-with-jasmine-revised](http://railscasts.com/episodes/261-testing-javascript-with-jasmine-revised).


## Installation Instructions
1) Clone the repository and be sure to supply a name for the new application (using lowercase letters only and underscores if needed)

```
git clone git://github.com:activefx/alpha.git <new_application_name>
```

2) From the new application directory, create a named gemset and .rvmrc file to keep your project dependencies seperate and self-containted. 

```
rvm use 1.9.3-p392@<new_application_name> --create
```

3) Install all the required gems by running bundler

```
bundle install
```

4) Run the rake command to "install" the application. The task simply renames the alpha application to the name you chose in step 2 and creates a new secret token. On a side note, it is a recommended Rails security practice to add the secret_token.rb initializer to your .gitignore file, but I have not done so for convenience in rapid prototyping. If your code will be public, you should add it to .gitignore.

```
rake development:install
```

5) Commit your progress to git. You know have a starting point to begin building your application.

```
git add .
git commit -m 'installed alpha'
```

## Development

Alpha relies on Foreman to manage sensative environment variables, so using rails server and rails console commands will not work.

### Starting the server

```
foreman start
```

### Starting the Rails console

```
foreman run rails console
```

I recommend creating command line aliases for these to avoid having to type them out each time.

## Testing

### Running the tests

To run the specs, you can use the rspec command.

```
bundle exec foreman run rspec
```

However, using Guard and Spork to rapidly prototype via a test driven workflow allows for greater productivity.

To start guard, run:

```
bundle exec guard
```

This does four things, as per the [guardfile](https://github.com/activefx/alpha/blob/master/Guardfile):

1) Ensures the dependencies are up to date via Bundler

2) Loads LiveReload, which automatically reloads your browser when view files are modified

3) Starts Spork so you do not have to reload the application each time you run the tests

4) Starts the Jasmine test runner for the javascript specs

None of the tests are configured to run when you load Guard, but you can run all of the tests by hitting enter from the Guard command prompt. You can also run only the RSpec specs or Jasmine specs with the commands "specs" or "js". A list of all Guard commands is available by entering "help guard".

You may receive an error notice "Timeout waiting for the Jasmine test runner.", but you should still be able to run the javascript specs anyway. If not, increase the timeout option in the guard jasmine configuration within the Guardfile.

Because the full Guard configuration could take up to a few minutes to load, the guardfile is seperated into groups. This allows you to use Guard to load only the development tools you are using at the time. For example:

Loading only LiveReload (for HTML & CSS development)

```
bundle exec guard -g livereload
```

Loading only Spork and RSpec (for Ruby / Rails development)

```
bundle exec guard -g specs
```

Loading only Jasmine (for Javascript development)

```
bundle exec guard -g js
```



## Configuring the Application

### Configuring Devise

### Configuring Omniauth

## Deploying to Heroku

Alpha uses [heroku-api](https://github.com/heroku/heroku.rb) and [paratrooper](https://github.com/mattpolito/paratrooper) to provision and deploy a new Heroku app.

## Configuring Your Production Environment

### Downloading Your Configuration Variables

### Scaling the App to Additional Dynos

### Adding a Worker Dyno for Sidekiq

### Serving Assets Via S3

### Adding Exceptional for Error Handling

### Adding Mailchimp


## TODO

* Create a command line application to install and deploy the application
* Add Stripe for payment processing

## Miscellaneous
Interested in an application skeleton for creating Ruby gems? Check out [beta](https://github.com/activefx/beta).

## License

Copyright © 2011 - 2013 Matthew Solt

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.






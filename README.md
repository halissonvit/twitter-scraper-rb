# README

A sample web application that scrapes Twitter for tweets about MLH Localhost and displays them in an attractive manner.

[![CircleCI](https://circleci.com/gh/halissonvit/twitter-scraper-rb.svg?style=svg)](https://circleci.com/gh/halissonvit/twitter-scraper-rb)

## Dependencies

* [Ruby 2.5.1](https://www.ruby-lang.org/en/) - A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.

* [Ruby on Rails 5.2.0](https://rubyonrails.org/) - Rails is a web application development framework written in the Ruby programming language. It is designed to make programming web applications easier by making assumptions about what every developer needs to get started. 

* [Nokogiri](https://www.nokogiri.org/) - Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors.

* [Rubocop](http://batsov.com/rubocop/) - RuboCop is a Ruby static code analyzer. Out of the box it will enforce many of the guidelines outlined in the community Ruby Style Guide.

* [Rubycritic](https://github.com/whitesmith/rubycritic) - RubyCritic is a gem that wraps around static analysis gems such as Reek, Flay and Flog to provide a quality report of your Ruby code.

## Running the application

### Install Ruby and Ruby on Rails

[GoRails Setup Guide](https://gorails.com/setup/) is one of the best resources to get Ruby on Rails up and running on your machine.

### Clone the project

`git clone https://github.com/halissonvit/twitter-scraper-rb.git`

### Install the dependencies

`bundle install`

### Start the application

`bundle exec rails s`

## Running the tests and quality analysis tools

### Run the tests

`bundle exec rails s`

### Run Rubocop

`bundle exec rubocop`

### Run Rubycritic

`bundle exec rubycritic`
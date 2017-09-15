# _@TwittamirPutin_

#### By _*Ezra Sandzer-Bell, Chris Clifford, Luke Philips, and Adam Zinder*_

## Description
Twittamir Putin is a web app for searching and translating twitter, as well as translating and tweeting user created content. It covers English, Spanish, Russian, Japanese and emojis. It uses the Twitter API, Google API, and our own custom emoji translator. Deployed live at http://twittamir-putin.herokuapp.com.

The user can search Twitter for tweets by keyword or user, then display all translations. The user can then retweet any translation from the @TwittamirPutin handle. The user can also write their own content to translate, with the option to tweet it from the @TwittamirPutin handle.

The emoji translator uses a db of all emojis with corresponding tags. Sentences are parsed into words and then each word is run against the db for a case insensitive match. If no match is found, all substrings of the word are run against the db, and any substrings matches are replaced by their emoji in order of substring length (i.e.: Chickenhouse => ["chicken"+"house"] => 🐔
🏘, and the substring match of "chick" is superceded by "chicken due to substring length").

The app contains functionality to tweet back emoji translations to the most recent mention, though this feature is hidden.

## Setup/Installation Requirements

* Clone this repo: `https://github.com/c1iff/twitter-app`
* Change to the repo directory
* Install gems: `bundle install`
* Install the database: *instruction below*
* Run the app: `ruby app.rb`

## Database Setup Instructions

* install and start postgres
* run: `bundle exec rake db:create`
* run: `bundle exec rake db:migrate`
* run: `bundle exec rake db:seed`

## Technologies Used

_Ruby, Sinatra, SQL, Postgres, JavaScript, MaterializeCSS, jQuery_

### License

*MIT License*

Copyright (c) 2016

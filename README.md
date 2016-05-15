# WPOHT2016

[![Build Status](https://travis-ci.org/makeus/WPOHT2016.svg?branch=master)](https://travis-ci.org/makeus/WPOHT2016)
[![Coverage Status](https://coveralls.io/repos/github/makeus/WPOHT2016/badge.svg?branch=master)](https://coveralls.io/github/makeus/WPOHT2016?branch=master)

WPOHT2016 is a project for [Web-Palvelinohjelmointi 2016](https://github.com/mluukkai/WebPalvelinohjelmointi2016/wiki/projekti). The project is a ruby on rails application with a ReactJS frontend.

## Demo

Demo can be viewed in [Heroku](https://wpoht2016.herokuapp.com/)

## Documentation

Documantion can be viewed in the github wiki page [here](https://github.com/makeus/WPOHT2016/wiki)

## Setup

The software requires dependencies to be installed first. You can do this by running

```
bundle install
```

The application requires a key to Google Maps API which can be retrieved [here](https://developers.google.com/maps/documentation/javascript/get-api-key). This key needs to added to the ENV as GOOGLE_API_KEY. This can be done with the command 

```
export GOOGLE_API_KEY = [key]
```

The rails production server can be started with

```
rails server -e production
```

Tests can be run with

```
bundle exec rspec
```

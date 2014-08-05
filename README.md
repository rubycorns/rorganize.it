## RailsGirlsApp [![Build Status](https://travis-ci.org/rubycorns/RailsGirlsApp.png?branch=master)](https://travis-ci.org/rubycorns/RailsGirlsApp)

You visited a Rails Girls Workshop and now want to join a project group to really learn the way of the code?
This little app is just the one for you!

An overview of who meets when, where, with whom to work on what.

### Just some general information:

Ruby version 2.0+

Rails version 4.1

Make sure you have ImageMagick installed.

In Terminal run (OSX):

    brew install imagemagick
    
Or for Linux run (or with the package manager of your choice):

    sudo apt-get install imagemagick

### Get the code
Get the code from this repo

    git clone


### Run locally
Install all the gems

    bundle install

Spice up the database

    rake db:migrate

Run the server

    rails s 

et voilá


### Git: branches 
Create new branch (you should be in the directory of the project) 
    
    git branch Name_of_your_branch
    
Switch to the newly created branch (the same if you need to change to the branch that already exist) 
    
    git checkout Name_of_your_branch

Or for lazy people like Tobi (does both steps at the same time):
    
    git checkout -b Name_of_your_branch    

Push the new branch to the repository (with some commits or just "bare" branch) 
    
    git push --set-upstream origin Name_of_your_branch
    
Delete local branch

    git branch -D Name_of_your_branch
    
    
### Git: commit your changes
Make changes, then 
    
    git add -A

Tell the others what you did
    
    git commit -m “description of changes”

Off to Github
    
    git push
    
### Make a pull request
1. Select your branch on github.
2. Click 'Pull Request'.
3. Write a little summary of what you did and alert people if you need help.
4. If it is a **small** change, wait for one thumbs up from a fellow rubycorns member before merging.
5. If it is a **large** change, wait for one thumbs up from a coach **and** one from a rubycorns member
before merging.

### Deploy to shelly cloud

We are now graciously hosted by [shelly](https://shellycloud.com/)

1. Nudge Tobi to invite you to the shelly cloud
2. [Follow the shelly cloud join an existing cloud steps](https://shellycloud.com/documentation/joining_existing_cloud)
3. You can now deploy with `git push shelly` (just like heroku, just with a shelly)

App runs at: http://railsgirlsapp.shellyapp.com/

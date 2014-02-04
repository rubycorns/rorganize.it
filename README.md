## RailsGirlsApp [![Build Status](https://travis-ci.org/rubycorns/RailsGirlsApp.png?branch=master)](https://travis-ci.org/rubycorns/RailsGirlsApp)

You visited a Rails Girls Workshop and now want to join a project group to really learn the way of the code?
This little app is just the one for you!

An overview of who meets when, where, with whom to work on what.

### Just some general information:
Ruby version 1.9.3  
Rails version 4.0
Make sure you have ImageMagick installed.
In Terminal run 

    brew install imagemagick

### Get the code
Get the code from this repo

    git clone


### Deploy
Install all the gems

    bundle install

Spice up the database

    rake db:migrate

Run the server

    rails s 

et voilá


### Git: branches 
Create new branch (you should be in the directory of the project) 
    
    git branch "Name_of_your_branch"
    
Switch to the newly created branch (the same if you need to change to the branch that already exist) 
    
    git checkout "Name_of_your_branch"

Or for lazy people like Tobi (does both steps at the same time):
    
    git checkout -b Name_of_your_branch    

Push the new branch to the repository (with some commits or just "bare" branch) 
    
    git push --set-upstream origin Name_of_your_branch
    

### Git: commit your changes
Make changes, then 
    
    git add -A

Tell the others what you did
    
    git commit -m “description of changes”

Off to Github
    
    git push



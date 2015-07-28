
## RailsGirlsApp [![Build Status](https://travis-ci.org/rubycorns/rorganize.it.svg)](https://travis-ci.org/rubycorns/rorganize.it) [![Stories in Ready](https://badge.waffle.io/rubycorns/rorganize.it.png?label=ready&title=Ready)](https://waffle.io/rubycorns/rorganize.it)

You visited a Rails Girls Workshop and now want to join a project group to really learn the way of the code?
This little app is just the one for you!

An overview of who meets when, where, with whom to work on what.

To see the current status of the project and who's working on what, go to https://waffle.io/rubycorns/railsgirlsapp

### Contributing

We've had lots of people asking us if this project is open for all to work on and if they can contribute
even though they are a) not women, b) not in our project group, c) don't know us, d) some other reason. The answer is of course yes! We are not a closed group and we welcome your PRs. All we ask is that you communicate with us regularly, make clean PRs, test your work, and be nice. If you write some crazy code, explanations are helpful so that we can learn
from what you've done and become better coders ourselves in the process. If you have a great idea for a feature & want to implement it, please open an issue, assign yourself to it, and hack away :)

### Just some general information:

Ruby version 2.0+

Rails version 4.1

Make sure you have ImageMagick installed.

In Terminal run (OS&nbsp;X):

    brew install imagemagick
    
Or for Linux run (or with the package manager of your choice):

    sudo apt-get install imagemagick

### Get the code
Get the code from this repo

    git clone


### Run locally

Get all the secrets:

    cp config/secrets.yml.sample config/secrets.yml
    
Install all the gems

    bundle install

Spice up the database

    rake db:migrate
    
Get some data

    rake db:seed

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
    
    git commit -m "description of changes"

Off to GitHub
    
    git push
    
### Make a pull request
1. Select your branch on GitHub.
2. Click 'Pull Request'.
3. Write a little summary of what you did and alert people if you need help.
before merging.
4. When you merge and close your branch, please make sure to include a [ridiculous gif](https://github.com/rubycorns/RailsGirlsApp/pull/281#issuecomment-64454385). 

### Deploy to Shelly Cloud

We are now graciously hosted by [Shelly](https://shellycloud.com/)

1. Nudge Tobi or Lisa to invite you to the Shelly Cloud.
1. Do NOT register online, use the command line option.
1. [Follow the Shelly Cloud "Joining to Existing Cloud" steps](https://shellycloud.com/documentation/joining_existing_cloud).
1. You can now deploy with `shelly login` (enter email and password), and then `git push shelly` (just like Heroku, just with a Shelly).

App runs at: http://rorganize.it

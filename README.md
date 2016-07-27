
## Rorganize.it [![Build Status](https://travis-ci.org/rubycorns/rorganize.it.svg?branch=master)](https://travis-ci.org/rubycorns/rorganize.it)

You visited a Rails Girls Workshop and now want to join a project group to really learn the way of the code? Or maybe you recently coached at a workshop and now want to do it on a regular basis! If that's the case, this little app is just the one for you!

An overview of who meets when, where, with whom to work on what.

### Contributing

We've had lots of people asking us if this project is open for all to work on and if they can contribute
even though they are a) not women, b) not in our project group, c) don't know us, d) some other reason. The answer is of course yes! We are not a closed group and we welcome your PRs. All we ask is that you communicate with us regularly, make clean PRs, test your work, and be nice. If you write some crazy code, explanations are helpful so that we can learn
from what you've done and become better coders ourselves in the process. If you have a great idea for a feature & want to implement it, please open an issue, assign yourself to it, and hack away :)

### Code of Conduct

You can learn about our [Code of Conduct online ](https://rorganize.it/conduct) or [in the repo](https://github.com/rubycorns/rorganize.it/blob/master/CODE_OF_CONDUCT.md)

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

    git clone git@github.com:rubycorns/rorganize.it.git


### Run locally

Get all the secrets:

    cp config/secrets.yml.sample config/secrets.yml

Install all the gems

    bundle install

Spice up the database

    bundle exec rake db:migrate
*Note: if running the migrations alters the schema.db file with changes such as unneccessary linebreaks and spaces, and you have not created any of your own migrations to specifically modify it, it's best not to commit the schema file. You can delete the modified file from your local copy by running `git checkout db/schema.rb`*

Get some data

    bundle exec rake db:seed

Run the server

    bundle exec rails s

et voilá

Run all the tests

    bundle exec rspec


### Git: branches
*Note*: you will need permission from rubycorns in order to push your branches to this repository.
Until you have been granted permission, please [fork](https://help.github.com/articles/fork-a-repo/) this repository,
and create a branch from your fork.

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

### Deploy

We are hosted by [Uberspace](https://uberspace.de/). The app runs at
(https://rorganize.it)[https://rorganize.it].

To deploy, run:

    git push production master

this will push the current version of the master branch from your
local repository to production, run bundler and precompile the assets
if necessary, and restart the server.

To set this up, first make that you have ssh access to the production
server. If this command works, then you have ssh access. If not, ask
someone of the Rubycorns to give you access.

    ssh ror@rorganize.it echo itworks

Then in your local repository, add a git remote for production:

    git remote add production ror@rorganize.it:html/rorganize.it

That should be it. The scripts that are run after a push are in the `deploy`
directory. See also https://github.com/mislav/git-deploy for more info.

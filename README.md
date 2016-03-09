# CICICI

Continuous Integration, Integration. Continuous Integration, Integration. Continuous Integration, Integration. *

### How to use

This is a simple add-on of sorts for any project with Travis CI.

Replace the called upon ENV vars in main.rb with the correct credentials.

* `g_k`: means your github token. You can generate one just for scripts in settings.

* `user`: is the user/organization

* `repo`: is the repo you want to check the latest master commit on

* `ip`: is the server ip you have ssh root access to.

After ssh there is a linux command in quotes.

Here you can write your own little ```cd favorite_project && service nginx stop && git pull && bundle && service nginx start```

Now you can make your own little custom scripts to automate updating your already built servers.

Travis CI can pause the commit to master and run tests.

This script will check every minute (in the python file) to see if a commit has been made to master.

Now you can just code, push, watch the tests pass, and watch your app be production ready!

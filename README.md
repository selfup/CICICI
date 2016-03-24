# CICICI

Continuous Integration, Integration. Continuous Integration, Integration. Continuous Integration, Integration. *

### How to use

This is a simple add-on of sorts for any project with Travis CI.

Replace the called upon ENV vars in ```./lib/deployer.rb``` with the correct credentials.

If you use rbenv: rbenv-vars should be your go to for ENV vars.

Make sure to ```echo .rbenv-vars >> .gitignore``` before committing!

* `g_k`: means your github token. You can generate one just for scripts in settings.

* `user`: is the user/organization

* `repo`: is the repo you want to check the latest master commit on

* `ip`: is the server ip you have ssh root access to.

After ssh there is a linux command in quotes.

Here you can write your own little ```cd favorite_project && service nginx stop && git pull && bundle && service nginx start```

Now you can make your own little custom scripts to automate updating your already built servers.

Change the tests to your liking, as well as the directories being manipulated.

This is my more of a pre-baked template that you must understand. But if you are low on time, and all of this makes sense to you, this tool is easy to patch for your needs.

Travis CI can pause the commit to master and run tests.

Now you can just code, push, watch the tests pass, and watch your app be production ready!

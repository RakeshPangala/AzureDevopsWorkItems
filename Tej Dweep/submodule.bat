$ git clone "https://github.com/Tej424/Devops.git"
$ git clone "https://github.com/Tej424/Developer.git"
$ git submodule add -f -b master https://github.com/Tej424/Devops.git TejModule
$ git add .
$ git commit -m "Linking Module"
$ git push origin master
$ git status
$ git add .
$ git commit -m "HI"
$ git push origin master
$ git submodule update --recursive --init
$ git submodule foreach git pull origin master



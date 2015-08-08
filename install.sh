#!/bin/bash

git submodule update --init --recursive
chmod +x git_hooks/pre-commit
ln git_hooks/pre-commit .git/hooks/

# install code coverage
sudo apt-get install python-pip
sudo pip install gcovr

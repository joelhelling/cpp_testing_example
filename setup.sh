#!/bin/bash

# install pre-commit git hook
chmod +x git_hooks/pre-commit
ln git_hooks/pre-commit .git/hooks/
# install code coverage
sudo apt-get install python-pip
sudo pip install gcovr
# install gmock
wget https://googlemock.googlecode.com/files/gmock-1.7.0.zip
unzip gmock-1.7.0.zip
mv gmock-1.7.0 gmock
rm gmock-1.7.0.zip
# install gtest
wget https://googletest.googlecode.com/files/gtest-1.7.0.zip
unzip gtest-1.7.0.zip
mv gtest-1.7.0 gtest
rm gtest-1.7.0.zip
# install tool for parsing html
sudo apt-get install html-xml-utils

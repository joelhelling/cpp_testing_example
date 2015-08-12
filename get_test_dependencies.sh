#!/bin/bash

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
# update g++
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -qq
if [ "$CXX" = "g++" ]; then sudo apt-get install -qq g++-4.8; fi
if [ "$CXX" = "g++" ]; then export CXX="g++-4.8" CC="gcc-4.8"; fi

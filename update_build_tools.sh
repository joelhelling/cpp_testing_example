#!/bin/bash

# g++4.8.1
if [ "$CXX" == "g++" ]; then sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test; fi
echo 'added ppa'
sudo apt-get update -qq
echo 'apt-get update'
if [ "$CXX" == "g++" ]; then sudo apt-get install -qq g++-4.8; fi
echo 'download g++-4.8'
if [ "$CXX" == "g++" ]; then export CXX="g++-4.8"; fi
echo 'set CXX variable'

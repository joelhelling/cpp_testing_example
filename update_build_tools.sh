#!/bin/bash

# g++4.8.1
if [ "$CXX" == "g++" ]; then sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test; fi
sudo apt-get update -qq
if [ "$CXX" == "g++" ]; then sudo apt-get install -qq g++-4.8; fi
if [ "$CXX" == "g++" ]; then export CXX="g++-4.8"; fi

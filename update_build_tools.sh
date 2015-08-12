#!/bin/bash

# update g++
# g++4.8.1
if [ "$CXX" == "g++" ]
  then sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
  sudo apt-get update -qq
  sudo apt-get install -qq g++-4.8
  export CXX="g++-4.8"
fi

echo $CXX

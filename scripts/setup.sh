#!/bin/bash

SCRIPTS_DIR='scripts/'

# install submodules
git submodule update --recursive
# install pre-commit git hook
chmod +x git_hooks/check_whitespace.sh
chmod +x git_hooks/pre-commit
ln git_hooks/pre-commit .git/hooks/pre-commit
# install dependencies
chmod +x $SCRIPTS_DIR'get_test_dependencies.sh'
./$SCRIPTS_DIR'get_test_dependencies.sh'
# install code coverage
sudo apt-get install python-pip
sudo pip install gcovr
# install tool for parsing code coverage html report
sudo apt-get install html-xml-utils

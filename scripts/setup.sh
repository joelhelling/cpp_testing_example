#!/bin/bash

SCRIPTS_DIR='scripts/'
GIT_HOOKS_DIR='git_hooks/'

# install submodules
git submodule update --recursive
# install pre-commit git hooks
chmod +x $GIT_HOOKS_DIR'check_whitespace.sh'
chmod +x $GIT_HOOKS_DIR'check_code_coverage.sh'
chmod +x $GIT_HOOKS_DIR'run_tests.sh'
chmod +x $GIT_HOOKS_DIR'pre-commit'
ln $GIT_HOOKS_DIR'pre-commit' .git/hooks/pre-commit
# install dependencies
chmod +x $SCRIPTS_DIR'get_test_dependencies.sh'
./$SCRIPTS_DIR'get_test_dependencies.sh'
# install code coverage
$SCRIPTS_DIR'get_code_coverage_dependencies.sh'
# install tool for parsing code coverage html report
sudo apt-get install html-xml-utils

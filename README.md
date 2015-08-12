CPP Testing Example
===================
[![Build Status](https://travis-ci.org/spencewenski/cpp_testing_example.svg?branch=master)](https://travis-ci.org/spencewenski/cpp_testing_example)

This is an example of how to set up Google testing frameworks for a project.

Features
--------
- Testing Support (Google Test)
- Mocking support (Google Mock)
- Code coverage support
- Continuous Integration with Travis CI
- Sample Makefile
- Sample test cases
- A pre-commit git hook to run all the tests and check code coverage


Install
-------
Run the setup script

```
# clone the repo
git clone git@github.com:spencewenski/cpp_testing_example.git
cd cpp_testing_example
# run the setup script
make setup
```

Or run these commands
```
# clone the repo
git clone git@github.com:spencewenski/cpp_testing_example.git
cd cpp_testing_example
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
```


Build the project
-----------------
```
make
```


Run the tests
-------------
```
make test
```


Code coverage
---------------------------------
Generating a code coverage report
```
make generate_code_coverage_report
```
Then open the generated report (gcovr-report.html) in your browser.

Or, use the check_code_coverage script to verify the code coverage percentage.
```
# make sure the script is executable
chmod +x git_hooks/check_code_coverage.sh
# run the script
./git_hooks/check_code_coverage.sh
```
Set the minimum required code coverage percentage by changing the
MINIMUM_COVERAGE_PERCENTAGE variable in the script.


Committing changes
------------------
```
git add .
git commit -m 'message'
```
The pre-commit hook will run before the commit is finalized. The hook will
run the tests and check code coverage. If any tests fail or the code coverage
percentage is below the minimum required, git will abort the commit.


Continuous Integration with Travis CI
-------------------------------------
1. Setup an account at https://travis-ci.org/
2. Wait for Travis to sync with your github repositories
3. Turn on Travis for your repo at https://travis-ci.org/profile/<github username>
4. Modify .travis.yml as desired
5. Commit changes
6. Push changes to github
7. Update the Travis badge in the README by following the instructions [here](http://docs.travis-ci.com/user/status-images/)


References
----------
[Google Test](https://code.google.com/p/googletest/)  
[Google Mock](https://code.google.com/p/googlemock/)  
[Code Coverage](http://gcovr.com/)  
[Travis CI](http://docs.travis-ci.com/)  

CPP Testing Example
===================
This is an example of how to set up Google testing frameworks for a project.

Features
--------
- Sample Makefile
- Sample test cases (Google Test)
- A pre-commit git hook to run all the tests
- Code coverage support
- Mocking support (Google Mock)


Install
-------
Run these commands

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
```

Or run the setup script

```
# clone the repo
git clone git@github.com:spencewenski/cpp_testing_example.git
cd cpp_testing_example
# run the setup script
make setup
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


Generating a code coverage report
---------------------------------
```
make generate_code_coverage_report
```
Then open the generated report (gcovr-report.html) in your browser.


Committing changes
------------------
```
git add .
git commit -m 'message'
```
The pre-commit hook will run before the commit is finalized. The hook will
run the tests. If any tests fail, git will abort the commit.

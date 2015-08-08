CPP Testing Example
===================
This is an example of how to set up the Catch testing framework for a project.

Features
--------
- Sample Makefile
- Sample test case
- A pre-commit git hook to run all the tests
- Code coverage support


Install
-------
```
# clone the repo
git clone --recursive git@github.com:spencewenski/cpp_testing_example.git
cd cpp_testing_example
# install pre-commit git hook
chmod +x git_hooks/pre-commit
ln git_hooks/pre-commit .git/hooks/
# install code coverage
sudo apt-get install python-pip
sudo pip install gcovr
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

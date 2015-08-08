CPP Testing Example
===================
This is an example of how to set up the Catch testing framework for a project.

Features
--------
- Sample Makefile
- Sample test case
- A pre-commit git hook to run all the tests


Install
-------
```
git clone git@github.com:spencewenski/cpp_testing_example.git
chmod +x install.sh
./install.sh
```


Build the project
-----------------
```
make -f submodules/Makefiles/Makefile -C .
```


Run the tests
-------------
```
make -f submodules/Makefiles/Makefile -C . test
```


Committing changes
------------------
```
git add .
git commit -m 'message'
```
The pre-commit hook will run before the commit is finalized. The hook will
run the tests. If any tests fail, git will abort the commit.

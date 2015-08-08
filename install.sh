#!/bin/bash

git submodule update --init --recursive
chmod +x git_hooks/pre-commit
cp git_hooks/pre-commit .git/hooks/

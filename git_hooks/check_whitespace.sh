#!/bin/bash
#
# An example hook script to verify what is about to be committed.
# Called by "git commit" with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
#
# Usage:
# Remove the .sh file extension when you put the script in your hooks folder!
#
# Purposes:
# Add an empty line at the end of the file.
# Remove trailing spaces at the end of a line.
#
# Source: http://eng.wealthfront.com/2011/03/corrective-action-with-gits-pre-commit.html
# Version: 2011-03-08
# Related: http://stackoverflow.com/questions/13223868/how-to-stage-line-by-line-in-git-gui-although-no-newline-at-end-of-file-warnin


# Files (not deleted) in the index
files=$(git diff HEAD --name-only | grep -v ^D)
for f in $files
do
  if [[ "$f" =~ [.](conf|css|erb|html|js|json|log|properties|rb|ru|txt|xml|yml|h|m|cpp|c|cc|sh)$ ]]
    then
    # Add a linebreak to the file if it doesn't have one
    if [ "$(tail -c 1 $f)" != "" ]
      then
      printf "    $f\t add newline\n"
      sed -i -e '$a\' $f
      git add $f
    fi
    # Remove trailing whitespace if it exists
    if grep -q "[[:blank:]]$" $f
      then
      printf "    $f\t remove trailing whitespace(s)\n"
      sed -i -e "s/[[:blank:]]\+$//g" $f
      git add $f
    fi
  fi
done

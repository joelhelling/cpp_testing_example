#!/bin/bash
#
# Add an empty line at the end of the file.
# Remove trailing spaces at the end of a line.
#
# based on: https://gist.github.com/johnjohndoe/4024222

# Files (not deleted) in the index
files=$(git diff --name-only HEAD | grep -v ^D)
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

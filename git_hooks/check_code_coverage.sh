#!/bin/bash
#
# Check that code coverage is at or above the minimum required percentage
# 
# exit 1 if the code coverage percentage is too slow

# set the minimuc code coverage percentage
MINIMUM_COVERAGE_PERCENTAGE=100

# colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NO_COLOR=`tput sgr0`

# generate the code coverage report
make generate_code_coverage_report

# normalize the coverage report html
hxnormalize -x gcovr-report.html > gcovr-report_normalized.html

# extract the total coverage percentages
hxselect body table tbody tr td table tbody tr td.headerTableEntry < gcovr-report_normalized.html \
| grep -o '[0-9]*\.*[0-9]*' > coverage_percentages.txt

# remove the files created by this script
function clean {
  rm gcovr-report_normalized.html
  rm coverage_percentages.txt
}

# compare two lines of the coverage_percentages.txt
# 
# $1 number of the first line
# $1 number of the second line
function line_compare {
  LINE_ONE=$(awk 'NR=='$1' {print}' coverage_percentages.txt)
  LINE_TWO=$(awk 'NR=='$2' {print}' coverage_percentages.txt)


  if [ $LINE_ONE -eq $LINE_TWO ]
    then
      return
    elif [ $LINE_TWO -eq 0 ]
      then
        return
    elif [ $(( $LINE_ONE * 100 / $LINE_TWO )) -ge $MINIMUM_COVERAGE_PERCENTAGE ]
      then
        return
    else
      echo "${RED}Code coverage is below the required minimum percentage. Please check the coverage report in gcovr-report.*${NO_COLOR}"
      clean
      exit 1
  fi
}

line_compare 1 2 # lines
line_compare 4 5 # branches

clean

printf "\n${GREEN}Code coverage check was successful! Thanks for writing great tests!${NO_COLOR}\n\n"

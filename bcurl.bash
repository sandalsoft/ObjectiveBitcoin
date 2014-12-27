#!/bin/bash

method=$1
# This doesn't work with boolean inputs.  They're currently being quoted, they should not be.
# re='^[0-9]+([0-9]?[.][0-9]+)?$'

re='^[0-9]+([.][0-9]+)?$'

bool_re='^(true|false)'
params=""
total=$#
((counter=1))

for var in $@
do
  # if it's the first argument ($1, the method name), skip it
  if [[ $counter -eq 1 ]]
    then
      ((counter=counter + 1))
      continue
  fi
  # If variable is a number,
  if  [[ $var =~ $re ]]
    then
      # Don't put in quotes
      params="$params $var"
    # var is a word
    else
      # put the word var in quotes
      params="$params \"$var\""
  fi
  #if it's not the last var, add a comma
  if [[ $counter -ne $total ]]
    then
      params="$params,"
    # it is the last var, so don't add a comma
    else
      params="$params"
    fi
((counter=counter + 1))
done

# Uncomment out --trace-ascii /dev/stdout to get verbose trace data on curl POST
curl  --user u:p --data-binary "{\"jsonrpc\": \"1.0\", \"id\":\"bcurl\", \"method\": \"$1\", \"params\": [$params]}"  -H 'content-type: text/plain'\; http://dev.sndl.io:18332/ | underscore print --outfmt pretty #--trace-ascii /dev/stdout


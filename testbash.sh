#!/bin/bash

test='{"name":"tfss-6aec4c8e-470f-442b-9227-fcc3ed17c334-hello.txt","url":"http://files.parsetfss.com/9bbe4565-233b-49ca-92d9-ab1d79afacc1/tfss-6aec4c8e-470f-442b-9227-fcc3ed17c334-hello.txt”}'

regexp='"name":"(.*)",'

if [[ $test =~ $regexp ]]; then
  name="${BASH_REMATCH[1]}"
  echo $name
else
  echo "no matches"
fi


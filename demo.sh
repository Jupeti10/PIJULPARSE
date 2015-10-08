#!/bin/bash

# TODO: Ota parametrina
# - tiedoston nimi
# - int
# - flag

FILE_NAME="file.txt"
flag=false
int=3


FILE_CONTENT="`cat $FILE_NAME`"

hash=`openssl dgst -sha1 $FILE_NAME | sed 's/^.*= //'`


PARSE_APP_ID=t1Hg3vjypwZsBrc5zAg1yXCfoHtkqN7brnzSm2vq
PARSE_REST_KEY=pKuNTc0sWK5AgsgwjTdWJE8SSV2bdwgTIErv9Fx7


url="https://api.parse.com/1/files/$FILE_NAME"
regexp='"name":"(.*)",'

added_file=$(curl -X POST -H "X-Parse-Application-Id: $PARSE_APP_ID" \
 -H "X-Parse-REST-API-Key: $PARSE_REST_KEY" -H "Content-Type: text/plain" -d "$FILE_CONTENT" $url)


if [[ $added_file =~ $regexp ]]; then
  name="${BASH_REMATCH[1]}"
else
  echo "ERROR: no matches"
fi
file_name=$name
echo "File added: $file_name"



curl -X POST -H "X-Parse-Application-Id: $PARSE_APP_ID" -H "X-Parse-REST-API-Key: $PARSE_REST_KEY" -H "Content-Type: application/json" \
  https://api.parse.com/1/classes/Patch \
  -d "{ \"flag\": "$flag",
  		\"hash\": \""$hash"\",
  		\"file\": {\"name\": \""$file_name"\",\"__type\": \"File\"},
  		\"int\": "$int"}" 
#!/bin/bash

# Parametrit:
# 1 flag: Boolean
# 2 int: Integer
# 3 path: String

if [[ "$#" != "3" ]]; then
 echo "#########################"
 echo "####      USAGE      ####"
 echo "#########################"
 echo "PARAMETERS:"
 echo "1) flag (true,flase)"
 echo "2) int (Int e.g. 4)"
 echo "3) file(e.g. file.txt)"
 exit 1
fi 


FILE_PATH="$3"
FILE_NAME="$(basename "$FILE_PATH")"
flag="$1"
int="$2"


#script_path="$(realpath "$0")"
#script_home="$(realpath "$(dirname "$real_script_path")")"

real_filepath="${FILE_PATH}"
FILE_CONTENT="$(cat "$real_filepath")"

hash=`openssl dgst -sha1 $real_filepath | sed 's/^.*= //'`

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

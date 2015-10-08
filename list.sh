  
PARSE_APP_ID=t1Hg3vjypwZsBrc5zAg1yXCfoHtkqN7brnzSm2vq
PARSE_REST_KEY=pKuNTc0sWK5AgsgwjTdWJE8SSV2bdwgTIErv9Fx7

echo "Fetching list af patches..."
patches=$(curl -X GET \
  -H "X-Parse-Application-Id: $PARSE_APP_ID" \
  -H "X-Parse-REST-API-Key: $PARSE_REST_KEY" \
  https://api.parse.com/1/classes/Patch)
echo "Patches found:"
echo $patches
#!/bin/bash

# this smoketest script courtesy of chatgpt
# yes, it is gross, but yes, it also checks the entire API surface
# and was quick n dirty

#* GET `pw/`: Returns a static string response with a 200 status code. 
#* GET `pw/<key>`: Get `key` from redis or 404 error if not found
#* POST `pw/<key>/<val>`: Sets the passed in `key` to the passed in `value`
#* DELETE `pw/<key>`: Delete `key` from redis.

# Check for hostname argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

hostname=$1
key="testKey"
value="testValue"

# Test 1: GET request to pw/
echo "Testing GET /pw/"
response=$(curl -s -L -o /dev/null -w "%{http_code}" http://$hostname/pw/)
if [ "$response" -eq 200 ]; then
    echo "GET /pw/ succeeded with status code $response"
else
    echo "GET /pw/ failed with status code $response"
fi

# Test 2: GET request to pw/<key> (expecting 404)
echo "Testing GET /pw/$key (before setting value)"
response=$(curl -s -L -o /dev/null -w "%{http_code}" http://$hostname/pw/$key)
if [ "$response" -eq 404 ]; then
    echo "GET /pw/$key correctly returned a 404 status code"
else
    echo "GET /pw/$key unexpectedly returned status code $response"
fi

# Test 3: POST request to pw/<key>/<val>
echo "Testing POST /pw/$key/$value"
response=$(curl -s -L -o /dev/null -w "%{http_code}" -X POST http://$hostname/pw/$key/$value)
if [ "$response" -eq 200 ]; then
    echo "POST /pw/$key/$value succeeded with status code $response"
else
    echo "POST /pw/$key/$value failed with status code $response"
fi

# Test 4: GET request to pw/<key> (after setting value)
echo "Testing GET /pw/$key (after setting value)"
response=$(curl -s -L -o /dev/null -w "%{http_code}" http://$hostname/pw/$key)
if [ "$response" -eq 200 ]; then
    echo "GET /pw/$key succeeded with status code $response"
else
    echo "GET /pw/$key failed with status code $response"
fi

# Test 5: DELETE request to pw/<key>
echo "Testing DELETE /pw/$key"
response=$(curl -s -L -o /dev/null -w "%{http_code}" -X DELETE http://$hostname/pw/$key)
if [ "$response" -eq 200 ]; then
    echo "DELETE /pw/$key succeeded with status code $response"
else
    echo "DELETE /pw/$key failed with status code $response"
fi

# Test 6: GET request to pw/<key> (after deletion)
echo "Testing GET /pw/$key (after deletion)"
response=$(curl -s -L -o /dev/null -w "%{http_code}" http://$hostname/pw/$key)
if [ "$response" -eq 404 ]; then
    echo "GET /pw/$key correctly returned a 404 status code after deletion"
else
    echo "GET /pw/$key unexpectedly returned status code $response after deletion"
fi

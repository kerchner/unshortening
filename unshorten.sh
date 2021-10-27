#!/bin/bash

[[ "abc" =~ ^"dabc".* ]]
if [[ "$1" =~ "https://twitter.com".* ]]  # if it starts with https://twitter.com/ then skip to the end
then
  echo "$1,200,$1"
else

  curl_result=$(curl -o /dev/null --max-time 10 --connect-timeout 5 --silent --head --write-out "$1,%{http_code},%{redirect_url}\n" "$1")
  url=$1
  httpcode=$(echo "$curl_result" | cut -d',' -f2)
  redirect_url=$(echo "$curl_result" | cut -d',' -f3)

  if [[ -z "$redirect_url" ]]  # if redirect_url is empty
  then
    echo "$url,$httpcode,$url"
  else
    echo "$url,$httpcode,$redirect_url"
  fi

fi

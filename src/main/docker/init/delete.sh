#!/usr/bin/env bash

name=$1

printf "Deleting Integration API Script $name\n\n"

curl -v -X DELETE -u admin:admin123  "http://127.0.0.1:8081/service/siesta/rest/v1/script/$name"

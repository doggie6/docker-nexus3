#!/usr/bin/env bash

jsonFile=$1

printf "Creating Integration API Script from $jsonFile\n\n"

curl -v -u admin:admin123 --header "Content-Type: application/json" 'http://127.0.0.1:8081/service/siesta/rest/v1/script/' -d @$jsonFile
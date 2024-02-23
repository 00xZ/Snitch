#!/bin/bash
echo "Fetching on: $1"
cd output/jsdump/
while read line;do
    echo $line
    wget $line 
done < $1
grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|ssh key|access key|secret token|oauth_token|oauth_token_secret|smtp" output/jsdump/*.js

### Change wget to curl for less mess you will have to pipe the grep after the curl

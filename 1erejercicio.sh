#!/bin/bash
declare -r urllist='/opt/scripts/url-list.txt'
declare -r email='victormusa@gmail.com'
dig A www.imujer.com +short | grep -a [^a-zA-Z.]  > $urllist
while read LINE; do
 wget "http://199.34.125.35/test?email"=$email"&record"=$LINE ; done <"$urllist"

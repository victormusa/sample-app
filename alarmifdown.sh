#!/usr/bin/env bash

#This is a simple script to see if our website is down and get a notification about it

NOTIFYEMAIL=guzman.braso+sample-alert@batangamedia.com
SENDEREMAIL=alerta@localhost
SERVER=http://10.127.0.10/index.php
PAUSE=60
FAILED=0
DEBUG=0

apt-get install -y heirloom-mailx

while true 
do
sudo curl -sSf $SERVER > /dev/null 2>&1
CS=$?
# For debugging purposes
if [ $DEBUG -eq 1 ]
then
    echo "STATUS = $CS"
    echo "FAILED = $FAILED"
    if [ $CS -ne 0 ]
    then
        echo "$SERVER is down"

    elif [ $CS -eq 0 ]
    then
        echo "$SERVER is up"
    fi
fi

# If the server is down and no alert is sent - alert
if [ $CS -ne 0 ] && [ $FAILED -eq 0 ]
then
    FAILED=1
    if [ $DEBUG -eq 1 ]
    then
        echo "$SERVER failed"
    fi
    if [ $DEBUG = 0 ]
    then
       echo "$SERVER went down $(date)" | sudo mailx -s "$SERVER went down" -r "$SENDEREMAIL" "$NOTIFYEMAIL" 
    fi

# If the server is back up and no alert is sent - alert
elif [ $CS -eq 0 ] && [ $FAILED -eq 1 ]
then
    FAILED=0
    if [ $DEBUG -eq 1 ]
    then
        echo "$SERVER is back up"
    fi
    if [ $DEBUG = 0 ]
    then
        echo "$SERVER is back up $(date)" | sudo mailx -s "$SERVER is back up again" -r "$SENDEREMAIL" "$NOTIFYEMAIL"
    fi
fi
sleep $PAUSE
done


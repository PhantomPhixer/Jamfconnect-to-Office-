#!/bin/sh

################################################################################
# script to check for a particular profile being deployed then take an action
# takes in an input of the profiles UUID
# This can be found by running the profiles command as admin
# "sudo profiles show"
################################################################################

profileRequired="${4}"


profileInstalled="0"

while [ "$profileInstalled" = "0" ]; do
sleep 1
profileInstalled=$(profiles show | grep -c "$profileRequired" )

done
echo "profile found"

# now get to the actions to take
# going to be a kill of jamfHelper
killall jamfHelper
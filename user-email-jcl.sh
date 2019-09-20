#!/bin/sh

#################################################################################
# This script finds the value in the jamf connect verify plist create dby jamf connect logon
# This is their upn or email address required for one click O365 setup
# This is then used to populate the users email address in jamf
# needs an EA to read in the receipt which can then be use in a smart group to scope the office one click config profile

#*################################################################################


loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

if [ -f /Users/"$loggedInUser"/Library/preferences/com.jamf.connect.verify.plist ]; then
readUPN=$(defaults read /Users/"$loggedInUser"/Library/preferences/com.jamf.connect.verify LastUser)
else
readUPN="none"
fi


if [ "$readUPN" = "none" ] || [ "$readUPN" = ""  ]; then
echo "no upn"
exit 0
else
mkdir -p /Library/Management/receipts
touch /Library/Management/receipts/deploy-office-profile
jamf recon -email "$readUPN"


exit 0
fi

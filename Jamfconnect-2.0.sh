#!/bin/sh

#################################################################################
# This script finds the value in the jamf connect state plist created by jamf connect logon
# This is their upn or email address required for one click O365 setup
# This is then used to populate the users email address in jamf

#*################################################################################


JAMF_BINARY="/usr/local/bin/jamf"
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

if [ -f /Users/"$loggedInUser"/Library/preferences/com.jamf.connect.state.plist ]; then
UPN=$(defaults read /Users/"$loggedInUser"/Library/preferences/com.jamf.connect.state DisplayName)
else
UPN="none"
fi


if [ "$UPN" = "none" ] || [ "$UPN" = ""  ]; then
echo "no upn"
exit 0
else
echo "UPN is $UPN"
"$JAMF_BINARY" recon -endUsername "$UPN"


exit 0
fi

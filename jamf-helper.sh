#!/bin/bash

type="${4}"
title="${5}"
heading="${6}"
text="${7}"
icon="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertNoteIcon.icns"



# ensure dock is loaded so that the end user must be logged in and not _mbsetupuser
dockStatus=$(pgrep -x Dock)
while [[ "$dockStatus" == "" ]]; do
	sleep 1
	dockStatus=$(pgrep -x Dock)
done

"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType "$type" -title "$title" -heading "$heading" -alignHeading centre -description "$text" -alignDescription centre -icon "$icon" &

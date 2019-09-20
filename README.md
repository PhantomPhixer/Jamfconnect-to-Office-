# What's this for? #

You have clients logging into Azure using Jamf connect Logon and want to get 
their email address so it can be used the Office and Outlook profiles to allow
one click setup of Office/Outlook [like this](https://www.jamf.com/blog/help-users-activate-microsoft-office-365-and-configure-outlook-in-one-click/)

## What's needed ##
There are two components required,the script and the EA

The script needs to run as a post user logon item in a policy.
The EA needs to be created and used to scope the smart group
The smart group scopes the Office profiles

and away we go....

## But first... ##

**In the Jamf connect Logon profile (JCL) ensure this key is set**

`<key>CreateVerifyPasswords</key>
			<true/>`
This makes JCL create the plist 
`/Library/preferences/com.jamf.connect.verify.plist`

in the users home
This contains the value `LastUser` which contains the account used to sign into Azure.

## In jamf ##
Create a script item and copy the contents of the script into it

Create an EA and copy the contents of the EA
![ EA ](/Jamfconnect-to-Office- /images/EA.png)

Create a smart group and set it to use the EA

![ SG ](/Jamfconnect-to-Office- /images/SG.png)

Create the Outlook and Office profiles. I use [profile creator](https://github.com/ProfileCreator/ProfileCreator)
Use $EMAIL as the address where required

![ Profile ](/Jamfconnect-to-Office- /images/Profile.png)


Use the smart group to scope the profiles. This ensures the profiles do not deploy until the $EMAIL
value is actually available

![ Deployed ](/Jamfconnect-to-Office- /images/deployedprofile.png)

## To get it all working ##

Create a policy that runs once after user logon. Incluse the script in it.
This finds the UPN, sets the EA source value then runs an inventory with the email option
which updates the users email field and sets the EA to yes.
This sets the smart group membership and deploys the profiles...

all done in a few seconds before the user opens Outlook.
If you really need to be sure throw a cover screen, depnotify or jamf helper, up until the profiles have deployed.

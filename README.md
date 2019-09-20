# What's this for? #

You have clients logging into Azure using Jamf connect Logon and want to get 
their email address so it can be used for the Office and Outlook profiles to allow
one click setup of Office/Outlook [like this](https://www.jamf.com/blog/help-users-activate-microsoft-office-365-and-configure-outlook-in-one-click/)

## What's needed ##
There are two components required,the script and the EA

The script needs to run as a post user logon item in a policy.
The EA needs to be created and used to scope the smart group
The smart group scopes the Office profiles for deployment.

and away we go....

## Jamf Connect Logon Profile ##

**In the Jamf connect Logon profile ensure this key is set**

`<key>CreateVerifyPasswords</key>
			<true/>`
			
This makes JCL create the plist 
`/Library/preferences/com.jamf.connect.verify.plist`

in the users home
This contains the value `LastUser` which contains the account used to sign into Azure.

## In Jamf ##
Create a script item and copy the contents of the script into it

Create an EA and copy the contents of the EA
![ EA ](https://github.com/PhantomPhixer/Jamfconnect-to-Office-/blob/master/images/EA.png)

Create a smart group and set it to use the EA

![SG](https://github.com/PhantomPhixer/Jamfconnect-to-Office-/blob/master/images/SG.png)

Create the Outlook and Office profiles. I use [profile creator](https://github.com/ProfileCreator/ProfileCreator)
Use `$EMAIL` as the address where required and ensure the `Auto Sign in` is set

![ Profile ](https://github.com/PhantomPhixer/Jamfconnect-to-Office-/blob/master/images/Profile.png)

Upload the profiles into Jamf, personally I export as plist and add them to the `Custom Settings` payload so I can see what's been set.

Use the smart group to scope the profiles. This ensures the profiles do not deploy until the $EMAIL
value is actually available.

![ Deployed ](https://github.com/PhantomPhixer/Jamfconnect-to-Office-/blob/master/images/deployedprofile.png)

## To get it all working ##

Create a policy that runs once after user logon. Include the script in it.
This finds the UPN in the Jamf Connect Verify plist, creates the file that the EA picks up then runs an inventory with the email option which updates the users email field and sets the EA to yes.

This sets the smart group membership and deploys the profiles...

all done in a few seconds before the user opens Outlook.
If you really need to be sure throw a cover screen, depnotify or jamf helper, up until the profiles have deployed.
I have included two simple scripts to do this. ensure the jamf helper script runs before anything else and the profile-deployed runs after anything else.

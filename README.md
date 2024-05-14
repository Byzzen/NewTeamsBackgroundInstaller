# NewTeamsBackgroundInstaller
Background installer for New-Teams


This powershell script updates, or installs new backgrounds for the Microsoft New Teams client. The installer is PowerShell based. 

The script can be run, using Intune or another software deployment tool.


Update the pictures in the \Uploads folder and package it, like normal. Then use the Install.cmd to run the inataller. 
The script is a 2 setp rocket. 

The first step is to copy the files (C:\windows\customization\TeamsBackground and add the installer to run in user context after a restart. 
This is done using Active Setup.

The script checks if the New Teams windows application is installed, if not the script exits, and the detection method is not fulfilled.
this means that the BackgroundInstaller needs to be made available to the user, so that is it fails the user can install it again. The script will fail untill the New Teams client is installed. 

Install Command = Installer.cmd
Uninstall Command = N/A
Detection method = Detection method = File exists, C:\Windows\customization\TeamsBackground\CopyTeamsBackground.ps1

Intune settings:
Install command = install.cmd
Uninstall command = install.cmd
Installation time required (mins) = 10
Allow available uninstall = No
Install behavior = System
all other settinsg = default

(Requirements)
Operating system architecture = 64-bit
Minimum operating system = Windows 10 21H2
All other (Blank)

(Detection rule)
Rule Type = File
Path = C:\Windows\customization\TeamsBackground\
File or folder = CopyTeamsBackground.ps1
Detection methid = File or folder exists
Associated with a 32-bit app on 64-bit clients = No


No dependencies / you could if you install the New Teams client put that there.
No Supersedence

(Assignments)
Required = Your group of people/all
Available for enrolled devices = All Users

Uninstall = Blank



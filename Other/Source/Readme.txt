GIMP Portable Launcher
======================
Copyright 2004-2008 John T. Haller of PortableApps.com

Website: http://PortableApps.com/GIMPPortable

This software is OSI Certified Open Source Software.
OSI Certified is a certification mark of the Open Source Initiative.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


ABOUT GIMP PORTABLE
===================
The GIMP Portable Launcher allows you to run GIMP from a removable drive whose letter changes as you move it to another computer.  The program can be entirely self-contained on the drive and then used on any Windows computer.


LICENSE
=======
This code is released under the GPL.  The full code is included with this package as GIMPPortable.nsi.


INSTALLATION / DIRECTORY STRUCTURE
==================================
By default, the program expects one of these directory structures:

-\ <--- Directory with GIMPPortable.exe
	+\App\
		+\GIMP\
		+\gtk\ (Optional)
	+\Data\
		+\settings\

OR

-\
	+\CommonFiles\
		+\gtk\
	+\GIMPPortable\ <--- Directory with GIMPPortable.exe
		+\App\
			+\GIMP\
		+\Data\
			+\settings\


It can be used in other directory configurations by including the GIMPPortable.ini file in the same directory as GIMPPortable.exe and configuring it as details in the INI file section below.


GIMPPortable.INI CONFIGURATION
==============================
The GIMP Portable Launcher will look for an ini file called GIMPPortable.ini within its directory.  If you are happy with the default options, it is not necessary, though.  The INI file is formatted as follows:

[GIMPPortable]
GIMPDirectory=App\gimp
GTKDirectory=NONE
SettingsDirectory=Data\settings
GIMPExecutable=gimp-2.4.exe
AdditionalParameters=

The GIMPDirectory, GTKDirectory and SettingsDirectory entries should be set to the *relative* path to the appropriate directories from the current directory.  All must be a subdirectory (or multiple subdirectories) of the directory containing GIMPPortable.exe.  The default entries for these are described in the installation section above.

The GIMPExecutable entry allows you to set the GIMP Portable Launcher to use an alternate EXE call to launch GIMP.  This is helpful if you are using a machine that is set to deny gimp-2.4.exe from running.  You'll need to rename the gimp-2.4.exe file and then enter the name you gave it on the GIMPexecutable= line of the INI.

The AdditionalParameters entry allows you to pass additional commandline parameter entries to GIMP.exe.  Whatever you enter here will be appended to the call to GIMP.exe.


PROGRAM HISTORY / ABOUT THE AUTHORS
===================================
This launcher contains elements from multiple sources.  It is loosely based on the Firefox Portable launcher and contains some ideas from mai9 and tracon on the mozillaZine forums.
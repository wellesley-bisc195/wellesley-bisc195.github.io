# Part 0: Windows users need Windows Subsystem for Linux (WSL)

If you are working on a Mac,
you can skip this section and go straight to
[Lesson 1](/lessons/Lesson01/).

The inner guts of the Windows operating system
are different than those of Mac and Linux.
The bad news is, many computational biology tools
expect the later, a so-called "Unix" environment.
The good news is that Windows 10 has a way
to run a Unix environment side-by-side with Windows.

@@colbox-aqua
@@title
"Windows Users"
@@
Throughout this course,
you will see boxes like this labeled "Windows Users."
These contain information about ways in which
Windows is different from Unix operating systems.
**Pay careful attention** to these boxes,
since other instructions may be unclear if you don't modify them accordingly.
@@

@@colbox-orange
@@title
Warning
@@
I don't personally use Windows, so my ability to test things out is limited.
If anything doesn't work, please let me know _as soon as you can_!
I will do my best to find the solution and update the guide
so that other students don't have the same problem.
@@

Before you begin check to make sure that you have the [most recent version of Windows 10](https://support.microsoft.com/en-us/help/4028685/windows-10-get-the-update).

## Follow the installation guide

I suggest reading through this page before taking any action
so that you know what to expect.
It's not too long 😀.

[This page](https://docs.microsoft.com/en-us/windows/wsl/install-win10) has instructions
for enabling and installing WSL.
There are a couple of places where you have choices -
you may do what you like, but I recommend:

1. Simplified install - it currently requires that you join the Windows Insiders Program.
   1. This may also require you to update your operating system -
      be sure you have [a recent backup](https://www.wellesley.edu/lts/techsupport/software/code42)
      (you should be doing that anyway!).
2. If you do a manual install, I recommend installing the Ubuntu distribution,
   version 20.04 LTS.
3. [Install windows terminal](https://docs.microsoft.com/en-us/windows/wsl/install-win10#install-windows-terminal-optional)
   after you install linux, and use it for all of the terminal compentents of this course.

### Setting up your Linux username

1. At the end of the installation process,
   you will be asked to set a username and password.
   1. This will be the root / admin user for the linux installation
   2. It can be the same or different from your windows username and password,
      but I recommend that you do not include spaces in your username.
2. Also note that it will protect your password
   by not displaying it to the screen when you type,
   but it is registering your key strokes.

   @@colbox-blue
   @@title
   Note
   @@
   Security is important at all levels,
   so even though you have to use this password often,
   don't be tempted to make it too simple.
   Essentially all of your Window's files can be viewed and modified by this user,
   so keep that password safe and strong.

   Also be careful __not to mess with any permissions__!
   If you think you need to do that to complete this setup,
   then stop and reach out to me.
   You should NOT have to worry about any permissions with this,
   and if you do get stuck there then I need to know so I can help troubleshoot you through this,
   or so we know we need to update this guide.
   @@

## Updating Default Software

You will need to run a quick couple commands in order to run the software updater.
The Ubuntu OS is shipped with a ton of built-in software,
but those libraries may have had more recent updates come out
since the OS was shipped.
Updating this now is quick and will help you stay current and protected.

1. In the terminal,
   type `sudo apt-get update` and press enter.
   (you may need to enter your password)
   - [What does sudo apt-get update do?](https://askubuntu.com/questions/222348/what-does-sudo-apt-get-update-do)
1. Once that is complete,
   execute `sudo apt-get upgrade`.
   Press `y` when prompted.
   - [What does sudo apt-get upgrade do?](https://askubuntu.com/questions/94102/what-is-the-difference-between-apt-get-update-and-upgrade)
1. Once that is done, type `sudo apt autoremove`.
   This will remove any packages that are no longer needed.
   - [What does sudo apt-get autoremove do?](https://ubuntuforums.org/showthread.php?t=996053)

+++
title = "Scavenger Hunt"
number = 1
date = Date(2021,06,11)
+++

In this lab, you'll put your unix navigation skills to work!
I've constructed a (very rough) model of the Wellesley College campus
in a directory tree,
with "items" scattered throughout.
Items might be files, or text inside files -
your job is to find those items and then report the directions
to find each item in the form of file paths.

More specifics below, but first, some hints / reminders:

- `cd <arg>` where `<arg>` is a path to a directory (relative or absolute)
  is used to change working directories.
- `pwd` will show (print) the abolute path of your current working directory
- `ls <arg>` is used to list the contents of a directory,
  or files that match a glob pattern
  - the `-a` flag is used to list hidden files
  - the `-l` flag provides additional information,
    including whether the path is a file or directory.
  - if `ls` is used without arguments, it lists the contents of the working directory
- `cat <file(s)>` where `<file(s)>` is a path to file
  (or paths to multiple files separated by spaces) prints the contents of files
  to the screen

**These might be new**

- `grep <pattern> <file(s)>` where `<patttern>` is some string to look for
  and `<file(s)>` is paths to search, will show files that contain the pattern.
- `find <path> <expression>` recurssively search through `<path>` for files
  and directories that match `<expression>`. Lots of expressions are possible,
  but most useful for the current task will probably be `-name <something>` -
  for example,

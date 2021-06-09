+++
number = 2
title = "Using git for version control"
date = Date(2021,06,08)
lectures = [2]
assignments = [1]
chapters = [1]
concepts = [
    "Explain the use of 'version control' in the context of a coding project"
]
skills = [
    "Clone, commit to, and push from a git repository",
    "Use the `julia` REPL to do basic arithmatic"
]
+++

{{lesson_preamble}}

##

If you've ever worked on an assignment
and ended up with a list of files like

- `assignment1.docx`
- `assignment1_v2.docx`
- `assignment1_v2_kevins_comments.docx`
- `assignment1_v3_fix_final.docx`
- `assignment1_v3_fix_final_for_real_this_time.docx`

... you'll understand the importance of version control.

It goes well beyond naming of course.
How can you tell what changed between version 1 and version2?
Does version 3 take the comments Kevin made on v2 into account?
Is `...fix_final_for_real_this_time` _really_ the last version?

It's even worse if multiple people are working on the same document.
If you and your lab partner are editing a document at the same time,
How can you gracefully merge the changes?
What if the changes you make and the changes she makes are incompatible?

Software like Google Docs can address some of these issues,
but incompatible changes can still occur.
Imagine you're writing an essay about a dog.
At the beginning of the essay, you've written

> The quick brown fox jumped over the lazy dog

You and your partner are both refining this epic story at the same time,
and further on you write,

> Because of how lazy the dog was, she didn't chase the fox.

But your partner decided the first line needed some more detail
and changes it to

> The quick brown fox jumped over the lazy male dog.

so your pronouns are out of step.

In writing, a mistake like this might just look silly,
but in programming, it can mean your code doesn't run
or generates the wrong answer.
Even more critically,
code often involves many files working together,
and keeping track of the versions of multiple files at the same time is necessary.

## `git` is a program for version control

`git` is a distributed version control system (DVCS).
That is, it helps one keep track of one's code,
and the information about versions is distributed among many systems.

@@colbox-blue
@@title
Note
@@
Early version control systems were centralized -
there was a single server that kept track of
all of the information about a code repository.
Users could "checkout" individual files to edit them,
and the central repository would lock that file to prevent conflicting changes.
This makes it easy to prevent conflicts,
but is also a bit impractical.

By contrast, git is distributed -
each user's system contains the entire revision history,
and conflicts between versions are explicitly managed when
two different edits to the code are brought together.
Don't worry if this isn't super clear at this stage -
we'll get into some practical examples in a sec.
@@

You can think of a `git` "repository" (usually shortened to "repo")
as a directory with super powers.
If you're looking at the directory using Finder or Explorer,
it might not look any different,
but it's much more powerful.
Before we get into that, though,
we need to get `git` installed.

## Installing git

If you are using Windows Subsystem for linux,
or a linux operation system, `git` should already be installed.

But lets check - if `git` is installed, you can execute `git --help` in the terminal.

```sh
$ git --help
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
        [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
        [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
        [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
        <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
clone      Clone a repository into a new directory
init       Create an empty Git repository or reinitialize an existing one
# ... output truncated
```

If you're using a Mac, git might not be installed.
Executing the command above will probably result in an error message:

```
bash: git: command not found...
```

So you need to install it.
If the `git` help message appeared, you can skip [to here](#configuring_git)).

The easiest way to install git on a mac is using [`homebrew`](http://brew.sh).

If you're using a mac and don't have git installed,
enter the following commands into your terminal (excluding the `$`),
then press `enter` to execute.

```sh
$ xcode-select --install
```

This may prompt you to download and install "command line developer tools"
from the app store.
If it does, click install and follow the prompts.
When that's finished, and you see the command prompt (`$`) again, run the following command.
Note: this is a case when you should probably use copy/paste.

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
==> This script will install:
/usr/local/bin/brew
/usr/local/share/doc/homebrew
/usr/local/share/man/man1/brew.1
/usr/local/share/zsh/site-functions/_brew
/usr/local/etc/bash_completion.d/brew
/usr/local/Homebrew
==> The following new directories will be created:
/usr/local/sbin
# ...
```

And follow the prompts.
If you are asked for your password,
use the one you use to log into your computer.
Note that you will not see anything appear as you type,
just type the password and hit `enter`.

## Configuring git

The next step is to tell git your name and email address,
so that you are credited with the changes you make to repositories.
Enter the following commands,
changing the name and e-mail address to yours.

```sh
$ git config --global user.name "Kevin Bonham, PhD"
$ git config --global user.email kbonham@wellesley.edu
```

### Practice: Create your first git repository

**Step 1:** In your terminal,
change your working directory to your `Documents` folder (`~/Documents`)

@@colbox-aqua
@@title
Windows Users
@@
You can perform the following steps either in
the `Documents/` folder of your linux filesystem found at `~/Documents`,
or of your Windows filesystem, which is found at `/mnt/c/Users/<your_username>  Documents`
@@

**Step 2:** Next, create a new directory called `my_repo`.

@@colbox-green
@@title
Reminders
@@
- `cd` is the command for changing working directory
- `mkdir` is the command for making a directory

Look back at [Lesson 1](../Lesson01) for more information,
and don't worry if you need to keep looking up stuff like this.
The stuff you do regularly will become second nature,
and the other stuff is always a Google search away.
@@

**Step 3:** Now, change your working directory into the newly created `my_repo/`
and initialize a git repository using the command `git init`

```sh
my_repo $ git init
Initialized empty Git repository in /home/kevin/Documents/my_repo/.git/
```

@@colbox-orange
@@title
Checking Questions
@@
Is the path shown in the output a *relative* or *absolute* path?

If you use the command `ls` to list the contents of the current directory,
can you see the `.git/` directory that was created?
Why or why not?
@@

**Step 4:** Open the folder in your operating system's file system navigator
(Finder on a Mac, Explorer in Windows).
This folder appears empty right now,
but in fact, there's a hidden `.git` folder
that will include all of the version information
for all of the files that you track.

@@colbox-aqua
@@title
"Windows Users"
@@

If you created the repository in the linux filesystem,
the easiest way to do this is to execute `explorer.exe ./`
from the command line.
[See here](https://devblogs.microsoft.com/commandline/whats-new-for-wsl-in-windows-10-version-1903/)
for more information about how the Windows and Linux filesystems interact.
@@

Let's see how this works.

**Step 5:** Open the [`VS Code`](https://code.visualstudio.com/) text editor and create a new file,
then save it in your repository directory as `fox.txt`.

**Step 6:** In your terminal, list the contents of the directory
to be sure the file was created.

```sh
my_repo $ ls
fox.txt
```

When you create new files, git does not track them automatically.
Let's see what git sees at the moment:

```sh
$ git status
On branch master

No commits yet

Untracked files:
(use "git add <file>..." to include in what will be committed)

    fox.txt

nothing added to commit but untracked files present (use "git add" to track)
```

So `git` sees the file exists,
but it tells you it's not being tracked.

**Step 7:** Let's fix that (the `status` message helpfully tells you how):

```sh
my_repo $ git add fox.txt
my_repo $ git status
On branch master

No commits yet

Changes to be committed:
(use "git rm --cached <file>..." to unstage)

    new file:   fox.txt
```

The file is now "staged"[^stage] -
that is ready to be "committed."
In git, a "commit"[^commit] is used to register a specific version of a repository.
The current state of all of the tracked files in the repository
will be recorded.

We don't really need to track an empty file,
let's add some text to it.

**Step 8:** In VS Code, add the following line to `fox.txt` **and save**.

```
The quick fox jumped.
```

Now, back in the terminal, what's the status?

```sh
$ git status
On branch master

No commits yet

Changes to be committed:
(use "git rm --cached <file>..." to unstage)

    new file:   fox.txt

Changes not staged for commit:
(use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

    modified:   fox.txt
```

Notice that `fox.txt` now appears under both
"Changes to be committed" and
"Changes not staged for commit".

Why?
Because you initially staged an empty file,
and now there's a modified version of the file that has not been staged.
You can see the difference between the current state of the file
and what's staged using `git diff`

```sh
$ git diff fox.txt | cat
diff --git a/fox.txt b/fox.txt
index e69de29..395235f 100644
--- a/fox.txt
+++ b/fox.txt
@@ -0,0 +1 @@
+The quick fox jumped.
```

The syntax of this output is perhaps a bit confusing,
but it's saying that a line was added to `fox.txt`.

**Step 9:**
Let's go ahead and stage this change,
and then make our first commit.

```sh
$ git add fox.txt
$ git commit -m "my first commit"
[master (root-commit) b183d56] my first commit
1 file changed, 1 insertion(+)
create mode 100644 fox.txt
```

```sh
$ git status
On branch master
nothing to commit, working tree clean
```

Congratulations! You have a git repository.

### Just keep committing

@@colbox-purple
@@title
Practice
@@

Try making some more changes to this file,
make some new files,
and use `git add`,
`git commit`, and
`git status`
to keep track of those changes.
@@

@@colbox-red
@@title
Danger!
@@
If you enter `git commit` without including a commit message
with the `-m` flag,
your terminal may transform into a text editor.
If this happens,
you may find it difficult to return to the command prompt.
Try typing (don't copy/paste) `:q!` then `enter`.

If this doesn't work, ask for assistance.
If Kevin or the TAs are unavailable,
you can always close and re-open your terminal.

In either case, your commit will be aborted.
@@

### Using git in this course

It might not be clear to you yet why
using a version control system is worthwhile.
If you don't trust me,
the fact that almost every software company uses git (or something similar)
should give you some confidence that it's important.

In any case, this entire course will use git and github.com
(a website for managing and collaborating on git repositories).
In the [first assignment](/assignments/Assignment01),
you'll learn how to do this.

## Running julia code

For a lot of this course,
we will be using the julia programming language
rather than the command line.

There are a few different ways to run julia code,
and this section will get you acquaninted with a couple of them.

### The julia REPL

Open julia, which you [should have installed](@ref install_julia)
in the [first lesson](../lessons/Lesson01/#install_julia).

Your terminal application should open, running julia:

```
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.6.0 (2021-03-24)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```

Technically speaking,
this is the julia "Read, evaluate, print, loop", or "REPL".

When you enter text at the `julia>` prompt,
the REPL **read**s it,
**evaluate**s it as julia code,
**print**s the result,
and then **loop**s back to the prompt.

Let's try it! Type `println("Hello, World!")` at the prompt and hit enter.

```julia
println("Hello, World!")
```

Don't worry if you don't understand all of the components of this command - 
we'll get there.

@@colbox-green
@@title
Tip
@@
As much as possible, try typing out the commands in these lessons,
rather than copy-pasting.
It's important to build the muscle memory,
and to see the errors that appear when you have typos!

For example, what did I miss here:

```julia
println(Hello, World!)
```
@@

### Running julia from the command line

You can also execute short snippets of code from the command line.
But first, you need to tell the terminal where to look for the julia program.

Mac users, execute the following in your terminal:

```
$ echo 'export PATH=$PATH:/Applications/Julia-1.6.app/Contents/Resources/julia/bin/' >> ~/.bash_profile
```

@@colbox-aqua
@@title
Windows Users
@@
Your situation is a bit more complicated.
You'll need a separate julia installation
for your linux operating system in order to run julia
from the command line.

I will write up complete instructions soon.
@@

Then restart the terminal.
Don't worry if you don't understand what that command is doing -
it's not worth it to understand it at this moment. 

@@colbox-purple
@@title
 "To Do"
@@
Open your terminal and enter the following:

```sh
$ julia -e 'println("Hello, World!")'
Hello, World!
```
@@

The `-e` is a command-line flag that tells julia to just execute the next command as julia code.
Note the use of single quotes (`'`) surrounding the command.

@@colbox-orange
@@title
Checking Questions
@@

1. What happens if you just enter `julia` at the command line without additional arguments?
2. What happens if you use double quotes instead of single quotes? 
   Why do you think that is?
@@

### Running julia scripts

Our code is often going to be much more complicated than what we've done so far.
In those cases, and in order to keep a record of what we're doing,
it's useful to put our julia code in a file.

@@colbox-purple
@@title
To Do
@@

1. Open up VS Code, and create a new file called `hello.jl`.
2. Type `println("Hello, World!")` into the file and save it.
   Note the path to the directory where you saved the file!
3. run:

   ```sh
   $ julia <path_to_directory>/hello.jl
   ```
   ```
   Hello, World!
   ```
@@

When code is saved into a file that can be run from the commandline,
it's called a "script."
All of your assigments will be julia code written into files
and commited to code repositories using `git`.

But it's important to realize that all of this code is the same;
it's just text.
That text has specific requirements in order to be parsed
by the julia interpreter,
but whether you run code in the REPL,
from the command line,
or in a script,
it has the same behavior.

[^stage]: **stage** - Files with changes that are ready to be committed.

[^commit]: **commit** - A unique reference to a specific state of a repository.

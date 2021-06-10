+++
number = 2
title = "Why the Terminal?"
date = Date(2021, 06, 11)
+++

{{lecture_preamble}}

## Lab 2 - Scavenger Hunt!

In this lab, you will move around Wellesley finding items and locations...
in the terminal!

### Step 1 - Download and unpack the repository

Open the terminal and use `cd` to change to a directory that you want to use
(eg `~/Documents/bisc195`) or make a new directory.
Now, use `curl` (**c**lient **URL**) to download the file [found here](https://github.com/wellesley-bisc195/scavenger_hunt/archive/refs/tags/v0.1.1.tar.gz).

```sh
$ curl -LO https://github.com/wellesley-bisc195/scavenger_hunt/archive/refs/tags/v0.1.1.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   150  100   150    0     0    604      0 --:--:-- --:--:-- --:--:--   604
100  3485    0  3485    0     0   7884      0 --:--:-- --:--:-- --:--:-- 19914
```

By default, `curl` just prints the contents of the webpage to the screen,
the `-O` option says to use the file name provided by the url, in this case `v0.1.1.tar.gz`.
You could also use `-o <some_name>` to give it a different name or path.

The `-L` option tells `curl` to follow "redirects" -
don't worry about this. 
As always, if you want more information about shall commands,
use `man curl` or `curl --help`.
Alternatively, use the website [explainshell](https://explainshell.com/explain?cmd=curl+-LO+https%3A%2F%2Fgithub.com%2Fwellesley-bisc195%2Fscavenger_hunt%2Farchive%2Frefs%2Ftags%2Fv0.1.1.tar.gz).

This file is called a "tarball" - it's a group of directories and files
that are packaged and compressed using a function called **t**ape **ar**chive (`tar`),
named during a time when archiving data meant literally recording it on magnetic tapes.
We'll use the options `-x` (extract), `-z` (decompress - named for `gzip`),
`-v` (verbose - without this option, it will work, but nothing will be printed to the screen),
`-f <filename>` (tells `tar` what file to run the command on).

```sh
$ tar -xvzf v0.1.1.tar.gz
scavenger_hunt-0.1.0/
scavenger_hunt-0.1.0/README.md
scavenger_hunt-0.1.0/campus/
scavenger_hunt-0.1.0/campus/east/
# ... output truncated
```

Now, you may delete the tarball (optional) and change directories into `scavenger_hunt-0.1.0/`.
The video below shows me doing this on my terminal
(ignore the call to `bash` at the beginning).
It's a special kind of video where you can pause the video and copy text if you want!

~~~
<script id="asciicast-bBP2vmVhmmJJEk1shBVpCBg5I" src="https://asciinema.org/a/bBP2vmVhmmJJEk1shBVpCBg5I.js" async></script>
~~~

### Hunt!

Scattered throughout this directory are directories and files
that contain things to search for.
Working in pairs, **and using only the terminal**,
you will search through the file tree to accomplish the tasks.

In each pair, one person should be in charge of chosing what to do,
while the other person actually does the typing.
Learning to describe tasks and how to interpret those descriptions
are very useful skills!
It will also help you learn to think of these things in a different way.
Trade roles frequently.
Keep track of the answers in a text file.

If you find problems with the hunt - take note!
You will [have an opportunity](#bonus_help_me_improve_the_scavenger_hunt) to help me improve it.

Some pointers:

- You are not expected to have everything memorized - use references
- Review [the summary of lesson 1](/lessons/Lesson01/#summary_of_terminal_commands) - 
  a lot of those commands are going to be really useful
- There are many ways to accomplish all of these tasks, not all of which you've encountered.
  Try lots of approaches. Google for more ideas.
- You can use `cat` to look at the contents of one or more files,
  but if you pass multiple files, you won't necessarily know which one it came from.
- You can use `grep` to look for text inside files
  (`grep "coffee" *.txt` will look for the word "coffee" written inside any file with the `.txt` extension)

#### Task 1 - Find some food

I don't know about you, but I'm hungry!
Look around, and find a place to eat.

**1.1** What's the relative path from the root of the project (`scavenger_hunt-v0.1.1/`)
to the place you want to eat?

**1.2** What's on the menu?

#### Task 2 - Siesta

After eating a big meal, especially with the heat we've had lately,
it can be great to take a nap.

**2.1** What's the relative path _from where you ate_ to the best place to nap?
(this might be your dorm building, or a particularly nice couch)

#### Task 3 - Wake up

Uh Oh! You were so tired, you slept right through the night.
Time to get up and get a cup of coffee.

**3.1** Find somewhere that serves esspresso.
What's the relative path _from where you slept_ to the source of caffine.

**3.2** Does this place serve anything to eat?

#### Task 4 - Geese patrol

After coffee, it's time to meet a friend (outside) on Severance Green,
but beware the geese!

**4.1** What's the relative path _from where you got coffee_ to Sev Green?

**4.2** How many geese are there? ([don't count them by hand!](https://unix.stackexchange.com/questions/1125/how-can-i-get-a-count-of-files-in-a-directory-using-the-command-line))

**4.3** Some of the geese are _violent_! How many violent geese are there?

**4.4** What are the names of the _gentle_ geese?

#### Task 5 - Pain killers

Despite your best efforts to avoid them, you were assaulted by some geese.
You should probably take something for the pain.

**5.1** What is the _absolute_ path to a location where you can get some pain meds?
Use `~` to represent your home folder in this path.

**5.2** What other medications can you get there?

**5.3** Sugar always helps me feel better - what's your favorite candy that's on offer there?

### Task 6 - Sight seeing tour

A friend is visiting from out of town, you want to show them around.
Provide the _absolute_ path from root (`/`) to each of the following

**6.1** A door that sounds like something from _Harry Potter_.

**6.3** An outdoor spot where star-crossed lovers meet.

**6.3** A statue colloquially called the "vagina statue."

### Task 7 - Thai food

Phew! That was a lot of walking - time for dinner.
There are two Thai restaurants that you're trying to choose between.

**7.1** What are the relative paths _from `campus/`_ to each restaurant's menu?

**7.2** What are the differences between their menus?
Try to use [the `diff` command](https://explainshell.com/explain/1/diff) to explore
(I recommend the `-y` option)

## Bonus! Help me improve the scavenger hunt

I'm still not very familiar with the Wellesley campus,
so the scavenger hunt is pretty bare - you can help!

After you've taken this course,
you might be interested in being involved in open source development.
Much of the software written in julia,
including the entire programming language itself
is available for free - often both [free as in beer and free as in speech](https://www.howtogeek.com/howto/31717/what-do-the-phrases-free-speech-vs.-free-beer-really-mean/).

That software is often available on github or gitlab,
and you can download it, make changes, and if you like,
request that your changes are "merged" into the main repository
so that others can benefit.
Minor changes and changes from beginners are often welcomed,
even encouraged.

I've learned a TON from doing this in open source repositories -
many times people have spent considerably more time
helping me accomplish some thing than it would have taken
for them to just do it themselves ([here's an example](https://github.com/JuliaLang/julia/pull/29679)).

The process I describe here
is pretty common for contributing to open source projects -
let's get started!

### Step 1 - Fork and clone the repository

The first step is to "fork" the repository to your own github account.

![Fork repo](https://i.imgur.com/UT9xwFl.png)

You should see a copy of the repo under your own github account (1)
that is forked from the main repo.
Then, as you did with [assignment 1](/assignments/Assignment01),
copy the repository link by clicking the green "code" button (2).
Be sure to use the link to your fork (3), rather than the main repo)

![get repo url](https://i.imgur.com/I6o8zBM.png)

Clone the repo using that URL

```sh
$ git clone <your repo url>
```

### Step 2 - Make your changes and push

Make a new "branch" to hold your changes using `git checkout -b <branchname>`.
This ensures that, as you make changes,
it's always easy to get back to the original.
This isn't strictly necessary, but it's good practice,
and in longer development workflows, sometimes there are more changes to `main`
before you get to them, which can cause merge conflicts if you're not careful.

Then, use VS code or some other method to make your changes.
Be sure to add yourself as an author to the `README.md` file (if you want)!
Though actually, git will track the changes that you've made,
and you'll retain credit regardless.

Commit your changes as you make them.
Then `push` them - because you have a new branch, you need to tell `git`
where it should go.
Do this using `git push --set-upstream origin <branchname>`
(remember, `origin` is the default name of your `remote`).

(note - in this video, I use a terminal editor called `nano` to make the edits,
just so that you can see that in the terminal video).

~~~
<script id="asciicast-wCmuOGnTxCo1JyZFE6dZsuoh4" src="https://asciinema.org/a/wCmuOGnTxCo1JyZFE6dZsuoh4.js" async></script>
~~~

### Step 3 - Open a "Pull request"

On Github, signaling that you have changes that can be merged into the primary branch
is called a "Pull request" (often shortened to "PR").
When you've forked a repo, and made changes,
guthub will give you a handy prompt that you can make a PR with your new changes.

![start PR](https://imgur.com/AiFwuXz)

Click the big green button and follow the prompts.
I may ask you to make some changes or add new things.
As you do, keep pushing to the same branch
(you can just do `git push` from now on), and the PR will be automatically updated.

Congratulations! You're contributing to open source!

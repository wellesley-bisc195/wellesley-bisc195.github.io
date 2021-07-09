+++
number = 10
title = "Learn a new package!"
date = Date(2021, 7, 9)
+++

{{lecture_preamble}}

## Lab 10 - Learn a new package!

1. Browse packages on [Juliahub](https://juliahub.com/ui/Packages)
2. Pick a topic that interests you or that you want to use
   for your final project and search, or browse categories
3. Read the documentation - is there example code?
4. Install and run some examples

## Browse Packages

[Julia Observer](https://juliaobserver.com/) and [JuliaHub](https://juliahub.com/ui/Packages)
both aggregate information about packages registered in the ["General Registry"](https://github.com/JuliaRegistries/General),
which is where `Pkg` looks when you do things like `add SomePackage`.

They also have some notion of keywords and descriptions,
and allow you to search within the documentation of packages.
For example, say you want to make a boxplot -
what packages could you try?

![juliahub boxplot search](/assets/img/juliahub_boxplot.png)

I'll pick the first hit (not always the best choice).

## Try it out

Searching the documentation, I [see a couple of examples](https://juliahub.com/docs/UnicodePlots/Ctj9q/1.3.0/#Boxplot).
It's usually a good idea to run the example code and make sure it works
before starting to try your own stuff.
For your lab, you can use your final project analysis repo,
or activate a temporary environment

~~~
<script id="asciicast-ERdpWM0BQ5Uhb9TbqHenEfIj9" src="https://asciinema.org/a/ERdpWM0BQ5Uhb9TbqHenEfIj9.js" async></script>
~~~

Also be sure to modify the examples to try out different combinations of things.
Starting from a known-working set of code and incrementally changing it
is often the best way to become familiar with a package
and it's capabilities.

Say I want to add some color to my plots -
I just do `ctrl+f` (or `cmd+f` on mac) and look for "color".

## Keep going


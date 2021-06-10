using Parameters
using Dates
using Downloads
using Pluto

@with_kw struct Lesson
    number::Int = 99
    title::String = ""
    release::Date = Date(0)
    date::Date = Date(0)
    lectures::Vector{Int} = Int[]
    assignments::Vector{Int} = Int[]
    chapters::Vector{Any} = Any[]
    learning_objectives::NamedTuple = (concepts = String[], skills = String[])
    tasks::Vector{String} = String[]
end

@with_kw struct Assignment
    number::Int = 99
    release::Date = Date(0)
    title::String = ""
    due_date::Date = Date(0)
    link::String = ""
    classroom::String = ""
end

@with_kw struct Lecture
    number::Int = 99
    release::Date = Date(0)
    title::String = ""
    date::Date = Date(0)
end


function Lesson(path)
    m = match(r"Lesson(\d+)", path)
    number = isnothing(m) ? 99 : parse(Int, m.captures[1])
    title = pagevar(path, :title; default = "")
    release = pagevar(path, :release; default = Date(0))
    date = pagevar(path, :date; default = Date(0))
    lectures = pagevar(path, :lectures; default = Int[])
    assignments = pagevar(path, :assignments; default = Int[])
    chapters = pagevar(path, :chapters; default = Any[])
    skills = pagevar(path, :skills; default = String[])
    concepts = pagevar(path, :concepts; default = String[])
    learning_objectives = (; concepts, skills)
    tasks = pagevar(path, :tasks; default = String[])
    return Lesson(
        number,
        title,
        release,
        date,
        lectures,
        assignments,
        chapters,
        learning_objectives,
        tasks        
    )
end

Lesson(n::Int) = Lesson("lessons/Lesson$(lpad(n, 2, '0')).md")
getpath(l::Lesson) = joinpath("/lessons", "Lesson$(lpad(l.number, 2, '0'))")

function Lecture(path)
    number = pagevar(path, :number; default = 99)
    release = pagevar(path, :release; default = Date(0))
    title = pagevar(path, :title; default = "")
    date = pagevar(path, :date; default = Date(0))
    return Lecture(number, release, title, date)
end

Lecture(n::Int) = Lecture("lectures-labs/Lecture$(lpad(n, 2, '0')).md")
getpath(l::Lecture) = joinpath("/lectures-labs", "Lecture$(lpad(l.number, 2, '0')).md")
getfilepath(l::Lecture) = joinpath("lectures-labs", "slides/lecture$(lpad(l.number, 2, '0'))_slides.jl")
getslidespath(l::Lecture) = joinpath("/lectures-labs", "slides/lecture$(lpad(l.number, 2, '0'))_slides.pdf")


function Assignment(path)
    number = pagevar(path, :number; default = 99)
    release = pagevar(path, :release; default = Date(0))
    title = pagevar(path, :title; default = "")
    due_date = pagevar(path, :due_date; default = Date(0))
    link = pagevar(path, :link; default = "")
    classroom = pagevar(path, :classroom; default = "")
    return Assignment(number, release, title, due_date, link, classroom)
end

const classroom_link = "https://classroom.github.com/a/"

Assignment(n::Int) = Assignment("assignments/Assignment$(lpad(n, 2, '0')).md")
getpath(a::Assignment) = joinpath("/assignments", "Assignment$(lpad(a.number, 2, '0'))")
getclassroom(a::Assignment) = string(classroom_link, a.classroom)

const book_link = "https://benlauwens.github.io/ThinkJulia.jl/latest/book.html"
chapter_link(n::Int) = string(book_link, "#chap", lpad(n, 2, '0'))
chapter_link(s::String) = string(book_link, "#_", s)

lesson_badge(l::Lesson) = string(
    "[!", "[lesson", l.number, "link]",
    "(https://img.shields.io/badge/Lesson-", l.number,
    "-purple?style=for-the-badge)](", getpath(l), ")"
)

date_badge(l::Union{Lecture, Lesson}) = string(
    "!", "[lesson", l.number, "date]",
    "(https://img.shields.io/badge/Date-", 
    replace(string(l.date), "-"=>"--"),
    "-orange?style=for-the-badge)"
)

assignment_badge(a::Assignment) = string(
    "[!", "[assignment", a.number, "link]",
    "(https://img.shields.io/badge/Assignment-", a.number,
    "-darkblue?style=for-the-badge)](", getpath(a), ")"
)

due_badge(a::Assignment) = string(
    "!", "[assignment", a.number, "due]",
    "(https://img.shields.io/badge/Due-", 
    replace(string(a.due_date), "-"=>"--"),
    "-red?style=for-the-badge)"
)

classroom_badge(a::Assignment) = string(
    "[!", "[assignment", a.number, "link]",
    "(https://img.shields.io/badge/Github%20-", a.number,
    "-darkblue?style=for-the-badge)](", getclassroom(a), ")"
)

chapter_badge(chap::Union{Int,String}) = string(
    "[!", "[book chapter $chap]",
    "(https://img.shields.io/badge/Book-", 
    chap,"-blue?style=for-the-badge)](", chapter_link(chap), ")"
)

lecture_badge(l::Lecture) = string(
    "[!", "[lecture", l.number, "link]",
    "(https://img.shields.io/badge/Lecture-", l.number,
    "-purple?style=for-the-badge)](", getpath(l), ")"
)

function slides_badge(l::Lecture)
    path = getslidespath(l)
    if isfile(lstrip(path, '/'))
        return string(
        "[!", "[Lecture", l.number, " slides]",
        "(https://img.shields.io/badge/Slides-", 
        l.number,"-blue?style=for-the-badge)](", path, ")"
        )
    else
        return string(
        "[!", "[Lecture", l.number, " slides]",
        "(https://img.shields.io/badge/Slides-NA",
        "-blue?style=for-the-badge)](#)"
        )
    end
end


function hfun_include_lessons()
    lessons = [Lesson(joinpath("lessons", p)) for p in filter(f-> startswith(f, "Lesson"), readdir("lessons/"))]
    io = IOBuffer()
    for lesson in lessons
        lesson.release >= today() && continue

        write(io, Franklin.fd2html("""
            ### Lesson $(lesson.number) - [$(lesson.title)]($(getpath(lesson)))
            
            @@badges
            $(lesson_badge(lesson))
            $(date_badge(lesson))
            $(join([chapter_badge(c) for c in lesson.chapters], ' '))
            $(join([join([assignment_badge(a), due_badge(a)], ' ') for a in Assignment.(lesson.assignments)], ' '))
            @@
            """, internal=true))
    end
    return String(take!(io))
end

function hfun_include_assignments()
    assignments = [Assignment(joinpath("assignments", p)) for p in filter(f-> startswith(f, "Assignment"), readdir("assignments/"))]
    io = IOBuffer()
    for assignment in assignments
        assignment.release > today() && continue

        write(io, Franklin.fd2html("""
            ### Assignment $(assignment.number) - [$(assignment.title)]($(getpath(assignment)))
            
            @@badges
            $(assignment_badge(assignment))
            $(classroom_badge(assignment))
            $(due_badge(assignment))
            @@
            """, internal=true))
    end
    return String(take!(io))
end

function hfun_include_lectures()
    lectures = [Lecture(joinpath("lectures-labs", p)) for p in filter(f-> startswith(f, "Lecture"), readdir("lectures-labs/"))]
    io = IOBuffer()
    for lecture in lectures
        lecture.release > today() && continue

        write(io, Franklin.fd2html("""
            ### Lecture $(lecture.number) - [$(lecture.title)]($(getpath(lecture)))
            
            @@badges
            $(lecture_badge(lecture))
            $(date_badge(lecture))
            $(slides_badge(lecture))
            @@
            """, internal=true))
    end
    return String(take!(io))
end


function hfun_lesson_preamble()
    lesson = Lesson(locvar(:number))
    io = IOBuffer()
    write(io, Franklin.fd2html("""
        # [Lesson $(lesson.number) - $(lesson.title)]($(getpath(lesson)))
        
        @@badges
        $(date_badge(lesson)) {{Placeholder for slides}} $(join([join([assignment_badge(a), due_badge(a)], ' ') for a in Assignment.(lesson.assignments)], ' '))
        @@
        """, internal=true))
    
    write(io, Franklin.md2html("""
        ## Learning Objectives

        **Concepts** - After completing this lesson, students will be able to:

        $(join(["- $concept" for concept in lesson.learning_objectives.concepts], '\n'))

        **Skills** - After completing this lesson, students will be able to:

        $(join(["- $skill" for skill in lesson.learning_objectives.skills], '\n'))

        **Tasks** - This lesson is complete when students have:

        $(join(["- Read [Chapter: $c]($(chapter_link(c))) from _Think Julia_" for c in lesson.chapters], '\n'))
        $(join(["- Completed [Assignment$(lpad(a, 2, '0'))]($(getpath(Assignment(a))))" for a in lesson.assignments], '\n'))
        $(join(["- $task" for task in lesson.tasks], '\n'))
        - Run all code examples from Lesson $(lesson.number) on their own computers

        """))
    return String(take!(io))
end

function hfun_assignment_preamble()
    assignment = Assignment(locvar(:number))
    io = IOBuffer()
    write(io, Franklin.fd2html("""
        # [Assignment $(assignment.number) - $(assignment.title)]($(getpath(assignment)))
        
        @@badges
        $(classroom_badge(assignment))
        $(due_badge(assignment))
        @@
        """, internal=true))
    return String(take!(io))
end

function hfun_lecture_preamble()
    lecture = Lecture(locvar(:number))
    io = IOBuffer()
    # make_lecture_slides(lecture)
    write(io, Franklin.fd2html("""
        # [Lecture $(lecture.number) - $(lecture.title)]($(getpath(lecture)))
        
        @@badges
        $(date_badge(lecture)) $(slides_badge(lecture))
        @@
        """, internal=true))
    return String(take!(io))
end

function hfun_literate_assignment(n)
    ln = parse(Int, first(n))
    return Franklin.fd2html("""
    ## Assignment$(lpad(ln, 2, '0')) code

    For each assignment, the contents of the assignment code script
    will be rendered as html at the bottom of the assignment description page.
    If you're interested in how that works, check out [Literate.jl](https://fredrikekre.github.io/Literate.jl/v2/)


    \\literate{/assignment_repos/Assignment$(lpad(ln, 2, '0'))/src/assignment.jl}""", internal=true)
end

function make_lecture_slides(lecture)
    s = Pluto.ServerSession();
    nb = Pluto.SessionActions.open(s, getfilepath(lecture); run_async=false)
    html_contents = Pluto.generate_html(nb)
    write("lectures-labs/slides/Lecture$(lpad(lecture.number, 2, '0')).html", html_contents)
end

function hfun_include_lab()
    lecture = Lecture(locvar(:number))
    lab = pagevar(locvar())
    io = IOBuffer()
    write(io, Franklin.fd2html("""
         [Lab $(assignment.number) - $(assignment.title)]($(getpath(assignment)))
        
        @@badges
        $(classroom_badge(assignment))
        $(due_badge(assignment))
        @@
        """, internal=true))
    return String(take!(io))
end
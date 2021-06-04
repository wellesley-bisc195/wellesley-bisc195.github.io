using Parameters
using Dates
using Downloads

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
    date::String = ""
    link::String = ""
end


function default_pagevar(path, var, default)
    val = pagevar(path, var)
    return isnothing(val) ? default : val
end

function Lesson(path)
    m = match(r"Lesson(\d+)", path)
    number = isnothing(m) ? 99 : parse(Int, m.captures[1])
    title = default_pagevar(path, :title, "")
    release = default_pagevar(path, :release, Date(0))
    date = default_pagevar(path, :date, Date(0))
    lectures = default_pagevar(path, :lectures, Int[])
    assignments = default_pagevar(path, :assignments, Int[])
    chapters = default_pagevar(path, :chapters, Any[])
    skills = default_pagevar(path, :skills, String[])
    concepts = default_pagevar(path, :concepts, String[])
    learning_objectives = (; concepts, skills)
    tasks = default_pagevar(path, :tasks, String[])
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

function Assignment(path)
    number = default_pagevar(path, :number, 99)
    release = default_pagevar(path, :release, Date(0))
    title = default_pagevar(path, :title, "")
    due_date = default_pagevar(path, :due_date, Date(0))
    link = default_pagevar(path, :link, "")
    classroom = default_pagevar(path, :classroom, "")
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

date_badge(l::Lesson) = string(
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

function hfun_literate_assignment(n)
    ln = parse(Int, first(n))
    isdir("_literate/") || mkdir("_literate/")
    Downloads.download("https://raw.githubusercontent.com/wellesley-bisc195/Assignment$(lpad(ln, 2, '0'))/main/src/assignment.jl", "_literate/assignment$(lpad(ln, 2, '0')).jl")
    return Franklin.fd2html("""
    ## Assignment$(lpad(ln, 2, '0')) code

    For each assignment, the contents of the assignment code script
    will be rendered as html at the bottom of the assignment description page.
    If you're interested in how that works, check out [Literate.jl](https://fredrikekre.github.io/Literate.jl/v2/)


    \\literate{/_literate/assignment$(lpad(ln, 2, '0')).jl}""", internal=true)
end
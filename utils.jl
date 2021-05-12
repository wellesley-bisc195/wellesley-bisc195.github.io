using Parameters
using Dates

@with_kw struct Lesson
    number::Int = 99
    title::String = ""
    release::Date = Date(0)
    date::Date = Date(0)
    lectures::Vector{Int} = Int[]
    assignments::Vector{Int} = Int[]
    chapters::Vector{Any} = Any[]
    learning_objectives::NamedTuple = (concepts = String[], skills = String[])
end

@with_kw struct Assignment
    number::Int = 99
    release::Date = Date(0)
    title::String = ""
    due_date::String = ""
    link::String = ""
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
    return Lesson(
        number,
        title,
        release,
        date,
        lectures,
        assignments,
        chapters,
        learning_objectives        
    )
end

Lesson(n::Int) = Lesson("lessons/Lesson$(lpad(n, 2, '0')).md")
getpath(l::Lesson) = joinpath("/lessons", "Lesson$(lpad(l.number, 2, '0'))")

lesson_badge(l::Lesson) = string(
    "[!", "[lesson", l.number, "link]",
    "(https://img.shields.io/badge/Lesson-", l.number,
    "-purple)](", getpath(l), ")"
)

date_badge(l::Lesson) = string(
    "!", "[lesson", l.number, "link]",
    "(https://img.shields.io/badge/Date-", 
    replace(string(l.date), "-"=>"--"),
    "-orange)"
)
function hfun_include_lessons()
    lessons = [Lesson(joinpath("lessons", p)) for p in filter(f-> startswith(f, "Lesson"), readdir("lessons/"))]
    io = IOBuffer()
    for lesson in lessons
        lesson.release > today() && continue
        @show date_badge(lesson)
        write(io, Franklin.md2html("""
            ### [$(lesson.title)]($(getpath(lesson)))
            $(lesson_badge(lesson)) $(date_badge(lesson))
            """))
        write(io, Franklin.md2html(""""""))
    end
    return String(take!(io))
end



# same for hfun_include_assignments
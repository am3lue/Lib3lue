# app/controllers/home_controller.jl
using Genie, GenieTemplates

@get("/home") do
    html() do
        body(h1("Book Collection"))
    end
end

@get("/", mime="text/html") 
function index()
    @layout app.layout
    html() do
        home()
    end
end

@get("/search", args=:q, mime="text/html") 
function search(q::String)
    results = filter(k -> occursin(lowercase(q), lowercase(k)), keys(books))

    @layout app.layout
    html() do
        home() | div() do
            h2("Search Results")
            ul() do
                for book in results
                    li(a(book, href="/preview/$book"))
                end
            end
        end
    end
end

@get("/preview/<title::String>", mime="text/html") 
function preview(title::String)
    if haskey(books, title)
        content = books[title]
        @layout app.layout
        html() do
            home() | div() do
                h2("Preview")
                pre(content)
            end
        end
    else
        "Book not found"
    end
end

@post("/upload", consumes=["multipart/form-data"]) 
function upload()
    form_data = Genie.Requests.formdata(Genie.Requests.request())

    if haskey(form_data, :file)
        file_path = joinpath("data/books", form_data[:file][:filename])
        open(file_path, "w") do io
            write(io, form_data[:file][:content])
        end

        load_books("data/books")

        redirect("/search?q=$(form_data[:file][:filename])")
    else
        return "No file selected"
    end
end

# app/controllers/home_controller.jl (update)
@get("/home") do
    html() do
        body() do
            h1("Book Collection")
            form(action="/upload", method="POST", enctype="multipart/form-data") do
                input(type="file", name="file")
                input(type="submit", value="Upload")
            end
        end
    end
end
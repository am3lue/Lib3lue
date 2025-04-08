# data/load_books.jl
using Genie

function load_books(book_dir::String)
    for filename in readdir(book_dir)
        if endswith(filename, ".txt")
            book_path = joinpath(book_dir, filename)
            title = splitext(filename)[1]
            content = readlines(book_path)
            books[title] = content
        end
    end
end

# Initialize books from a directory
load_books("data/books")
module Util

export save_uploaded_file, validate_files

function save_uploaded_file(upload, dest_path::String)
    open(dest_path, "w") do io
        write(io, upload.data)
    end
    return true
end

function validate_files(files, max_size::Int)
    valid = []
    invalid = []

    for f in files
        if f.size <= max_size
            push!(valid, f)
        else
            push!(invalid, Dict("file" => f.filename, "error" => "File too large"))
        end
    end

    return valid, invalid
end

end # module
using .Util: save_uploaded_file, validate_files
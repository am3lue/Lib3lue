# src/util.jl
module Util

"""
Save an uploaded file safely to disk.
"""
function save_uploaded_file(upload, dest_path::String)
    open(dest_path, "w") do io
        write(io, upload.data)
    end
    return true
end

"""
Validate uploaded files by size.
"""
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

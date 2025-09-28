include("util.jl")      # path relative to library.jl
using .Util: save_uploaded_file, validate_files

module Library

using Genie, Genie.Router, Genie.Renderer.Json, Genie.Requests
using Genie.Requests: payload, filespayload
using .Util: save_uploaded_file, validate_files

# --- Upload route ---
route("/api/upload/:category", method = POST) do
    try
        category = payload(:category, String)
        files = filespayload(:files)

        if isempty(files)
            return json(Dict("error" => "No files were uploaded"); status=400)
        end

        save_dir = joinpath("uploads", category)
        isdir(save_dir) || mkpath(save_dir)

        saved = []
        errors = []

        for upload in files
            try
                filepath = joinpath(save_dir, upload.filename)
                save_uploaded_file(upload, filepath)
                push!(saved, Dict("name" => upload.filename, "type" => category))
            catch e
                push!(errors, Dict("file" => upload.filename, "error" => string(e)))
            end
        end

        if isempty(saved)
            return json(Dict("error" => "No files were successfully uploaded", "details" => errors); status=400)
        end

        response = Dict("message" => "Files uploaded successfully", "files" => saved)
        if !isempty(errors)
            response["warnings"] = errors
        end

        return json(response)
    catch e
        return json(Dict("error" => "Server error: $(string(e))"); status=500)
    end
end

end # module
using .Library
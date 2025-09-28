# This file is part of the Lib3lue project
# (c) 2024 3lue Library Contributors
using PDFIO
using Genie, Genie.Router, Genie.Renderer.Json, Genie.Requests, Genie.Renderer.Html
using Genie.Requests: postpayload
using Random, Base

# Static page routes
route("/") do
  serve_static_file("index.html")
end

route("/about") do
  serve_static_file("about.html")
end

route("/contact") do
  serve_static_file("contact.html")
end

route("/docs") do
  serve_static_file(joinpath("assets", "others", "docs.html"))
end

route("/books") do
  serve_static_file(joinpath("assets", "others", "books.html"))
end

route("/faq") do
  serve_static_file(joinpath("assets", "others", "faq.html"))
end

route("/login") do
  # Show login form for GET requests
  if Genie.Router.params(:REQUEST_METHOD) == "GET"
    return serve_static_file(joinpath("entry-pages", "login.html"))
  end
  
  # Handle POST login form submission
  if Genie.Router.params(:REQUEST_METHOD) == "POST"
    email = params(:email, "")
    password = params(:password, "")
    
    if isempty(email) || isempty(password)
      return json(Dict("error" => "Email and password are required"), :bad_request)
    end
    
    # Todo: Add proper authentication against database/user store
    # Example validation logic:
    # user = authenticate_user(email, password)
    # if user !== nothing
    #   session(:user_id, user.id)
    #   return json(Dict("success" => true, "message" => "Login successful"))
    # end
    
    # For now return error
    return json(Dict("error" => "Invalid credentials"), :unauthorized)
  end
  
  # Return method not allowed for other HTTP methods
  return "Method not allowed", :method_not_allowed
end# Books related routes
route("/api/search", method=GET) do
  query = params(:q, "")
  books_dir = joinpath("public", "Books")
  
  if !isempty(query)
    files = readdir(books_dir)
    matched_files = filter(file -> occursin(lowercase(query), lowercase(file)), files)
    return json(matched_files)
  end
  
  return json([])
end

route("/Books/:filename") do
  filename = params(:filename)
  file_path = joinpath("public", "Books", filename)
  
  if isfile(file_path) && (
    endswith(lowercase(filename), ".pdf") || 
    endswith(lowercase(filename), ".epub") || 
    endswith(lowercase(filename), ".mobi") || 
    endswith(lowercase(filename), ".txt") || 
    endswith(lowercase(filename), ".doc") || 
    endswith(lowercase(filename), ".docx") || 
    endswith(lowercase(filename), ".djvu") || 
    endswith(lowercase(filename), ".azw") || 
    endswith(lowercase(filename), ".azw3") || 
    endswith(lowercase(filename), ".fb2") || 
    endswith(lowercase(filename), ".rtf") ||
    endswith(lowercase(filename), ".zip")
  )
    return serve_static_file(joinpath("Books", filename))
  else
    return "File not found", :not_found
  end
end
# docs relaetedd routes
route("/Docs/:filename") do
  filename = params(:filename)
  file_path = joinpath("public", "Docs", filename)
  
  if isfile(file_path) && (
    endswith(lowercase(filename), ".pdf") || 
    endswith(lowercase(filename), ".epub") || 
    endswith(lowercase(filename), ".mobi") || 
    endswith(lowercase(filename), ".txt") || 
    endswith(lowercase(filename), ".doc") || 
    endswith(lowercase(filename), ".docx") || 
    endswith(lowercase(filename), ".djvu") || 
    endswith(lowercase(filename), ".azw") || 
    endswith(lowercase(filename), ".azw3") || 
    endswith(lowercase(filename), ".fb2") || 
    endswith(lowercase(filename), ".rtf") ||
    endswith(lowercase(filename), ".zip")
  )
    return serve_static_file(joinpath("Docs", filename))
  else
    return "File not found", :not_found
  end
end

route("/api/docs/search", method=GET) do
  query = params(:q, "")
  music_dir = joinpath("public", "Docs")
  
  if !isempty(query)
    files = readdir(music_dir)
    matched_files = filter(file -> occursin(lowercase(query), lowercase(file)), files)
    return json(matched_files)
  end
  
  return json([])
end

# Music related routes
route("/music/:filename") do
  filename = params(:filename)
  file_path = joinpath("public", "Music", filename)
  
  if isfile(file_path) && endswith(lowercase(filename), (".mp3", ".wav", ".ogg", ".m4a", ".flac"))
    return serve_static_file(joinpath("Music", filename))
  else
    return "File not found", :not_found
  end
end

route("/api/music/search", method=GET) do
  query = params(:q, "")
  music_dir = joinpath("public", "Music")
  
  if !isempty(query)
    files = readdir(music_dir)
    matched_files = filter(file -> occursin(lowercase(query), lowercase(file)), files)
    return json(matched_files)
  end
  
  return json([])
end

# File upload routes
# route("/api/upload/books", method=POST) do
#     try
#         files = params(:files)
#         if files === nothing || isempty(files)
#             return json(Dict("error" => "No files were uploaded"); status=400)
#         end

#         upload_dir = joinpath("public", "Books")
#         if !isdir(upload_dir)
#             mkdir(upload_dir)
#         end

#         uploaded_files = String[]
#         errors = String[]

#         for file in files
#             try
#                 # Validate file extension
#                 filename = file.filename
#                 ext = lowercase(splitext(filename)[2])
#                 allowed_extensions = [".pdf", ".epub", ".mobi", ".txt", ".doc", ".docx", ".djvu", ".azw", ".azw3", ".fb2", ".rtf"]
                
#                 if !(ext in allowed_extensions)
#                     push!(errors, "Invalid file type: $filename")
#                     continue
#                 end

#                 # Validate file size (max 100MB)
#                 if length(file.data) > 100 * 1024 * 1024
#                     push!(errors, "File too large: $filename (max 100MB)")
#                     continue
#                 end

#                 # Sanitize filename
#                 safe_filename = replace(filename, r"[^a-zA-Z0-9._-]" => "_")
#                 file_path = joinpath(upload_dir, safe_filename)

#                 # Check if file already exists
#                 if isfile(file_path)
#                     safe_filename = "$(splitext(safe_filename)[1])_$(randstring(6))$(splitext(safe_filename)[2])"
#                     file_path = joinpath(upload_dir, safe_filename)
#                 end

#                 # Write file
#                 write(file_path, file.data)
#                 push!(uploaded_files, safe_filename)
#             catch e
#                 push!(errors, "Error processing $filename: $(string(e))")
#             end
#         end

#         if isempty(uploaded_files)
#             return json(Dict("error" => "No files were successfully uploaded", "details" => errors), :bad_request)
#         end

#         response = Dict("files" => uploaded_files)
#         if !isempty(errors)
#             response["warnings"] = errors
#         end

#         return json(response)
#     catch e
#         return json(Dict("error" => "No files were successfully uploaded", "details" => errors); status=400)
#     end
# end

# route("/api/upload/music", method=POST) do
#     try
#         files = params(:files)
#         if files === nothing || isempty(files)
#             return json(Dict("error" => "No files were uploaded"), :bad_request)
#         end

#         upload_dir = joinpath("public", "Music")
#         if !isdir(upload_dir)
#             mkdir(upload_dir)
#         end

#         uploaded_files = String[]
#         errors = String[]

#         for file in files
#             try
#                 # Validate file extension
#                 filename = file.filename
#                 ext = lowercase(splitext(filename)[2])
#                 allowed_extensions = [".mp3", ".wav", ".ogg", ".m4a", ".flac"]
                
#                 if !(ext in allowed_extensions)
#                     push!(errors, "Invalid file type: $filename")
#                     continue
#                 end

#                 # Validate file size (max 50MB)
#                 if length(file.data) > 50 * 1024 * 1024
#                     push!(errors, "File too large: $filename (max 50MB)")
#                     continue
#                 end

#                 # Sanitize filename
#                 safe_filename = replace(filename, r"[^a-zA-Z0-9._-]" => "_")
#                 file_path = joinpath(upload_dir, safe_filename)

#                 # Check if file already exists
#                 if isfile(file_path)
#                     safe_filename = "$(splitext(safe_filename)[1])_$(randstring(6))$(splitext(safe_filename)[2])"
#                     file_path = joinpath(upload_dir, safe_filename)
#                 end

#                 # Write file
#                 write(file_path, file.data)
#                 push!(uploaded_files, safe_filename)
#             catch e
#                 push!(errors, "Error processing $filename: $(string(e))")
#             end
#         end

#         if isempty(uploaded_files)
#             return json(Dict("error" => "No files were successfully uploaded", "details" => errors), :bad_request)
#         end

#         response = Dict("files" => uploaded_files)
#         if !isempty(errors)
#             response["warnings"] = errors
#         end

#         return json(response)
#     catch e
#         return json(Dict("error" => "Server error: $(string(e))"), :internal_server_error)
#     end
# end

# route("/api/upload/docs", method=POST) do
#     try
#         files = params(:files)
#         if files === nothing || isempty(files)
#             return json(Dict("error" => "No files were uploaded"), :bad_request)
#         end

#         upload_dir = joinpath("public", "Docs")
#         if !isdir(upload_dir)
#             mkdir(upload_dir)
#         end

#         uploaded_files = String[]
#         errors = String[]

#         for file in files
#             try
#                 # Validate file extension
#                 filename = file.filename
#                 ext = lowercase(splitext(filename)[2])
#                 allowed_extensions = [".pdf", ".doc", ".docx", ".txt", ".rtf"]
                
#                 if !(ext in allowed_extensions)
#                     push!(errors, "Invalid file type: $filename")
#                     continue
#                 end

#                 # Validate file size (max 50MB)
#                 if length(file.data) > 50 * 1024 * 1024
#                     push!(errors, "File too large: $filename (max 50MB)")
#                     continue
#                 end

#                 # Sanitize filename
#                 safe_filename = replace(filename, r"[^a-zA-Z0-9._-]" => "_")
#                 file_path = joinpath(upload_dir, safe_filename)

#                 # Check if file already exists
#                 if isfile(file_path)
#                     safe_filename = "$(splitext(safe_filename)[1])_$(randstring(6))$(splitext(safe_filename)[2])"
#                     file_path = joinpath(upload_dir, safe_filename)
#                 end

#                 # Write file
#                 write(file_path, file.data)
#                 push!(uploaded_files, safe_filename)
#             catch e
#                 push!(errors, "Error processing $filename: $(string(e))")
#             end
#         end

#         if isempty(uploaded_files)
#             return json(Dict("error" => "No files were successfully uploaded", "details" => errors), :bad_request)
#         end

#         response = Dict("files" => uploaded_files)
#         if !isempty(errors)
#             response["warnings"] = errors
#         end

#         return json(response)
#     catch e
#         return json(Dict("error" => "Server error: $(string(e))"), :internal_server_error)
#     end
# end


# Allowed extensions + max size (bytes) per category
const UPLOAD_RULES = Dict(
    "books" => ([".pdf", ".epub", ".mobi", ".txt", ".doc", ".docx", ".djvu", ".azw", ".azw3", ".fb2", ".rtf"], 100 * 1024 * 1024), # 100MB
    "music" => ([".mp3", ".wav", ".ogg", ".m4a", ".flac"], 50 * 1024 * 1024), # 50MB
    "docs"  => ([".pdf", ".doc", ".docx", ".txt", ".rtf"], 50 * 1024 * 1024)  # 50MB
)

# Sanitize filename
function safe_filename(name::String)
    return replace(name, r"[^a-zA-Z0-9._-]" => "_")
end

# Ensure unique filename by appending random string if file exists
function unique_filename(dir::String, filename::String)
    base, ext = splitext(filename)
    safe_name = safe_filename(base) * ext
    full_path = joinpath(dir, safe_name)
    
    while isfile(full_path)
        rand_tag = randstring(6)
        safe_name = "$(safe_filename(base))_$(rand_tag)$(ext)"
        full_path = joinpath(dir, safe_name)
    end
    return full_path
end

# Format file info
function file_info(path::String)
    return Dict(
        "name" => basename(path),
        "type" => splitext(path)[2][2:end],
        "path" => path
    )
end

# Generic upload handler
function handle_upload(category::String)
    try
        files = postpayload(:files)

        if isempty(files)
            return json(Dict("error" => "No files were uploaded"); status=400)
        end

        allowed_exts, max_size = UPLOAD_RULES[category]
        upload_dir = joinpath("uploads", category)
        isdir(upload_dir) || mkpath(upload_dir)

        saved_files = String[]
        errors = String[]

        for f in files
            try
                ext = lowercase(splitext(f.filename)[2])

                # Validate extension
                if !(ext in allowed_exts)
                    push!(errors, "Invalid file type: $(f.filename)")
                    continue
                end

                # Validate size
                if length(f.data) > max_size
                    push!(errors, "File too large: $(f.filename)")
                    continue
                end

                # Ensure unique safe filename
                save_path = unique_filename(upload_dir, f.filename)

                # Save file
                save_uploaded_file(f, save_path)
                push!(saved_files, save_path)
            catch e
                push!(errors, "Failed to save $(f.filename): $(e)")
            end
        end

        if isempty(saved_files)
            return json(Dict(
                "error" => "No files were successfully uploaded",
                "errors" => errors
            ); status=400)
        end

        response = Dict(
            "status" => "success",
            "message" => "Files uploaded successfully to $category",
            "files" => [file_info(path) for path in saved_files]
        )
        if !isempty(errors)
            response["warnings"] = errors
        end

        return json(response; status=200)
    catch e
        return json(Dict("error" => "Server error: $(string(e))"); status=500)
    end
end

# Unified route
route("/api/upload/:category", method = POST) do
    category = payload(:category)
    if !haskey(UPLOAD_RULES, category)
        return json(Dict("error" => "Invalid category: $category"); status=400)
    end
    return handle_upload(category)
end
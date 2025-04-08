using Genie.Router
using Genie.Renderer.Json
using Genie.Renderer.Html
using PDFIO

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
route("/Music/:filename") do
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

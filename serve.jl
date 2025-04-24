using Genie
using Pkg

# Activate the environment
Pkg.activate(".")

# Load the application
try
    println("Loading application...")
    Genie.loadapp()
    
    # Configure server settings
    Genie.config.run_as_server = true
    Genie.config.server_port = 8000
    Genie.config.server_host = "127.0.0.1"
    Genie.config.cors_headers["Access-Control-Allow-Origin"] = "*"
    Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
    Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    
    println("""
    Starting 3lue Library server...
    Server running at http://$(Genie.config.server_host):$(Genie.config.server_port)
    Press Ctrl+C to stop the server
    """)
    
    # Start the server
    up()
catch e
    println("Error starting server: $(string(e))")
    println("Stacktrace:")
    showerror(stdout, e)
    exit(1)
end
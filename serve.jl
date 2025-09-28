using Genie
using Pkg
using Sockets

# Function to get all valid network interfaces
function get_network_interfaces()
    interfaces = []
    try
        for iface in getipaddrs()
            ip_str = string(iface)
            # Filter out localhost and IPv6 addresses
            if !startswith(ip_str, "127.") && !startswith(ip_str, "::") && occursin(".", ip_str)
                push!(interfaces, ip_str)
            end
        end
    catch e
        println("Warning: Error getting network interfaces: $e")
        # Fallback to basic IP
        push!(interfaces, string(Sockets.getipaddr()))
    end
    return interfaces
end

# Clear screen
println("\033c")

# Activate the environment
Pkg.activate(".")

# Load the application
try
    println("📚 Loading 3lue Library application...")
    Genie.loadapp()
    
    # Configure server settings
    Genie.config.run_as_server = true
    Genie.config.server_port = 8000
    # Bind to all interfaces
    Genie.config.server_host = "0.0.0.0"
    
    # Configure CORS for local network access
    Genie.config.cors_headers["Access-Control-Allow-Origin"] = "*"
    Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
    Genie.config.cors_headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    
    # Get and display all network interfaces
    interfaces = get_network_interfaces()
    println("\n🌐 Access URLs (share these with people on your network):")
    for ip in interfaces
        println("  • http://$ip:$(Genie.config.server_port)")
    end
    println("  • http://localhost:$(Genie.config.server_port) (local access only)")

    # Clear screen
    #println("\033c")
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
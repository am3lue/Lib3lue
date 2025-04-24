using Pkg

# Create and activate the environment
Pkg.activate(".")

# Add required packages
required_packages = [
    "Genie",      # Web framework
    "HTTP",       # HTTP handling
    "JSON",       # JSON processing
    "FileIO"      # File operations
]

# Install packages if not already installed
for pkg in required_packages
    if !(pkg in keys(Pkg.project().dependencies))
        println("Installing $pkg...")
        Pkg.add(pkg)
    end
end

# Precompile packages
println("Precompiling packages...")
Pkg.precompile()

println("""
Environment setup complete!
To start the server, run:
julia serve.jl
""")

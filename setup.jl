using Pkg

# Function to read package names from the required_packages.txt file
function read_required_packages()
    packages = String[]
    open("required_packages.txt", "r") do file
        for line in eachline(file)
            # Skip empty lines
            isempty(strip(line)) && continue
            push!(packages, strip(line))
        end
    end
    return packages
end

# Function to install packages
function install_packages()
    println("📦 Installing required packages...")
    packages = read_required_packages()
    
    for package in packages
        println("Installing $package...")
        try
            Pkg.add(package)
        catch e
            println("⚠️ Error installing $package: $e")
        end
    end
end

# Main setup function
function setup()
    println("🚀 Starting project setup...")
    
    # Activate the project environment
    Pkg.activate(".")
    
    # Install required packages
    install_packages()
    
    println("✅ Setup completed!")
end

# Run setup
setup()
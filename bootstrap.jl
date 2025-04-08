(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using Library
const UserApp = Library
Library.main()

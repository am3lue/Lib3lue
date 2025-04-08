using Genie, Logging
using Sockets

# Get the IP address
ip_address = string(Sockets.getipaddr())

Genie.Configuration.config!(
  server_port                     = 8000,
  server_host                     =  ip_address,
  log_level                       = Logging.Info,
  log_to_file                     = false,
  server_handle_static_files      = true,
  path_build                      = "build",
  format_julia_builds             = true,
  format_html_output              = true,
  watch                           = true
)

ENV["JULIA_REVISE"] = "auto"
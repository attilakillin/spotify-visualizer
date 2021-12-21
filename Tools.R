timed <- function(message, target) {
  function(...) {
    # Start measurement
    start <- Sys.time()
    cat(message)
    
    # Run function and store result
    result <- target(...)
    
    # End measurement
    end <- Sys.time()
    cat(sprintf(" Done in %.3f seconds.\n", end - start))
    
    # Return result
    result
  }
}

save_plot <- function(plot, filename) {
  ggsave(filename, plot = plot, width = 1920, height = 1080, units = "px")
}

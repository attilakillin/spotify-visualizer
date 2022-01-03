timed <- function(message, target) {
  function(...) {
    cat(message)
    
    start <- Sys.time()
    result <- target(...)
    end <- Sys.time()
    
    cat(sprintf(" Done in %.3f seconds.\n", end - start))
    
    result
  }
}

save_plots <- function(plots, names) {
  mapply(function(plot, name) {
    ggsave(name, plot = plot, width = 1920, height = 1080, units = "px")
  }, plots, names)
}

# Parse Apple Music CSV files into a Spotify-compatible data frame
parse_apple <- function(filename) {
  list <- read.csv(filename)
  list <- list[which(
    list$Event.Type == "PLAY_END" & list$Play.Duration.Milliseconds > 0
  ),]
  
  data.frame(
    title = list$Song.Name,
    artist = list$Artist.Name,
    ms_played = list$Play.Duration.Milliseconds,
    end_time = as.POSIXct(list$Event.End.Timestamp, format = "%FT%R")
  )
} 

library("rjson")

# Parse spotify "StreamingHistory.json" files into a data frame
parse_spotify <- function(filename) {
  list <- fromJSON(file = filename)
  
  extract <- function(name) sapply(list, getElement, name)
  title     <- extract("trackName")
  artist    <- extract("artistName")
  ms_played <- extract("msPlayed")
  end_time  <- as.POSIXct(extract("endTime"), format = "%F %R")
  
  data.frame(title, artist, ms_played, end_time)
}

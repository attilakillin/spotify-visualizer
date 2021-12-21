library("rjson")
source("Tools.R")

.load_songs <- function(filename) {
  # Read object array into a list of lists
  list <- fromJSON(file = filename)
  
  # Extract the field with the given name from each sublist
  extract <- function(name) sapply(list, getElement, name)
  
  # Extract and format columns
  title     <- extract("trackName")
  artist    <- extract("artistName")
  ms_played <- extract("msPlayed")
  end_time  <- as.POSIXct(extract("endTime"), format = "%Y-%m-%d %H:%M")
  
  # Build and return data frame using the above columns
  data.frame(title, artist, ms_played, end_time)
}

load_songs <- timed("Parsing streaming history...", .load_songs)

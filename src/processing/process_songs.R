library("tidyr")

# Extract a specific field from a date object or vector.
.date <- function(col, field) as.integer(format(col, field))

# Process songs - minutes of music played per day grouped by the hour of day
# Columns: hour, play_mins
process_hourly <- function(songs) {
  formula <- ms_played / (1000*60) / 365.25 ~ .date(end_time, "%H")

  data <- aggregate(formula, songs, sum)
  names(data) <- c("hour", "play_mins")
  data <- complete(data, hour = 0:23, fill = list(play_mins = 0))
}

# Process songs - total minutes of music played grouped by the day of the year
# Columns: yday, week, wday, play_mins
process_daily <- function(songs) {
  year <- .date(songs$end_time[1], "%Y")
  days <- if (year %% 4 == 0) 1:366 else 1:365
  
  formula <- ms_played / (1000*60) ~ .date(end_time, "%j")
  
  data <- aggregate(formula, songs, sum)  
  names(data) <- c("yday", "play_mins")
  data <- complete(data, yday = days, fill = list(play_mins = 0))
  
  dates <- as.Date(days - 1, origin = sprintf("%d-01-01", year))
  frame <- tibble(
    yday = .date(dates, "%j"),
    week = .date(dates, "%W"),
    wday = .date(dates, "%u"),
    play_mins = data$play_mins
  )
}

source("src/tools.R")
source("src/parsing/parse_apple.R")
source("src/parsing/parse_spotify.R")
source("src/processing/process_songs.R")
source("src/visualizing/visualize_hourly.R")
source("src/visualizing/visualize_daily.R")
source("src/visualizing/visualizing_merge.R")


timed("Parsing listening history...", function() {
  songs_2020 <<- parse_spotify("data/2020/StreamingHistory.json")
  songs_2021 <<- parse_spotify("data/2021/StreamingHistory.json")
  songs_eni  <<- rbind(
    parse_apple("data/Eni/AppleStreaming.csv"),
    parse_spotify("data/Eni/SpotifyStreaming.json")
  )
})()

timed("Creating processed dataframes...", function() {
  data_20_hourly <<- process_hourly(songs_2020)
  data_21_hourly <<- process_hourly(songs_2021)
  data_eni_hourly <<- process_hourly(songs_eni)
  data_20_daily <<- process_daily(songs_2020)
  data_21_daily <<- process_daily(songs_2021)
  data_eni_daily <<- process_daily(songs_eni)
})()

timed("Creating plots from data...", function() {
  plots <<- list(
    plot_hourly(data_20_hourly, "2020", "springgreen"),
    plot_hourly(data_21_hourly, "2021 - Acsezs", "steelblue"),
    plot_hourly(data_eni_hourly, "2021 - Eni", "indianred"),
    plot_daily(data_20_daily, "2020", "springgreen"),
    plot_daily(data_21_daily, "2021 - Acsezs", "steelblue"),
    plot_daily(data_eni_daily, "2021 - Eni", "indianred")
  )
})()

timed("Saving plots...", function() {
  names <- list(
    "output/hourly_2020.png",
    "output/hourly_2021.png",
    "output/hourly_eni.png",
    "output/daily_2020.png",
    "output/daily_2021.png",
    "output/daily_eni.png"
  )
  
  save_plots(plots, names)
})()

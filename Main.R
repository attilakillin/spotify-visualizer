source("DataParse.R")
source("DataProcess.R")

songs <- load_songs("resources/2020/StreamingHistory.json")

save_plot(plot_hourly(songs), "hourly.png")

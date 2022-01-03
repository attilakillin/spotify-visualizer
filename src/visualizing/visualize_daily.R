library("ggplot2")
library("zoo")

# Create waffle plot for daily listening time distribution data
plot_daily_waffle <- function(data) {
  months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  days <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
  
  ggplot(data, aes(x = week, y = 7 - wday, fill = play_mins)) +
    geom_tile(color = "white", size = 0.7) +
    scale_x_continuous(breaks = seq(0, 50, 4.4), labels = months) +
    scale_y_continuous(breaks = seq(6, 0), labels = days)
}

# Create bar plot with rolling average for daily listening time
plot_daily_bar <- function(data) {
  months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  
  padded <- c(rep(0, 7), data$play_mins, rep(0, 7))
  
  ggplot(data, aes(x = yday, y = play_mins, fill = play_mins)) +
    geom_col(width = 1) +
    geom_line(aes(y = rollmean(padded, k = 15))) +
    scale_x_continuous(breaks = seq(1, 360, 30.5), labels = months) +
    scale_y_continuous(n.breaks = 5)
}

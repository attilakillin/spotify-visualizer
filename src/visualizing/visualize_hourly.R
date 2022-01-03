library("ggplot2")

# Create polar plot for hourly listening time distribution data
plot_hourly_polar <- function(data) {
  ggplot(data, aes(x = hour, y = play_mins, fill = play_mins)) +
    geom_col(width = 1, colour = "white") +
    coord_polar(start = -pi / 24) +
    scale_x_continuous(n.breaks = 12) +
    scale_y_continuous(n.breaks = 5)
}

# Create generic bar plot for hourly listening time distribution data
plot_hourly_bar <- function(data) {
  ggplot(data, aes(x = hour, y = play_mins, fill = play_mins)) +
    geom_col(width = 1, colour = "white") +
    scale_x_continuous(n.breaks = 9) +
    scale_y_continuous(n.breaks = 5)
}

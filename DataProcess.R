library("ggplot2")
library("patchwork")
library("plyr")
source("Tools.R")

.plot_hourly <- function(songs) {
  # Aggregate the input data
  songs$hours <- as.POSIXlt(songs$end_time)$hour
  groups <- aggregate(ms_played ~ hours, songs, sum)
  groups$mins_per_day <- groups$ms_played / (1000 * 60) / 365.25
  
  # Create polar bar chart and format using a helper function
  left <- ggplot(groups, aes(x = hours, y = mins_per_day, fill = mins_per_day))
  left <- .format_polar(left)
  
  # Create regular bar chart and format using a helper function
  right <- ggplot(groups, aes(x = hours, y = mins_per_day, fill = mins_per_day))
  right <- .format_bar(right)
  
  # Merge plots, add title and return result
  left + right + plot_annotation(
    title = "Hourly distribution of listening time during 2020",
    subtitle = "Average listening time (in minutes) in each hour, per day",
    theme = theme(
      plot.title = element_text(family = "Roboto", hjust = 0.5, size = 12),
      plot.subtitle = element_text(family = "Roboto", hjust = 0.5, size = 9)
    )
  )
}

plot_hourly <- timed("Creating hourly distribution...", .plot_hourly)

.format_common <- function(plot) {
  # Format text
  plot <- plot + xlab("Hour of day") + ylab("Minutes listened per day")
  
  # Format general theme
  plot <- plot + theme(
    text = element_text(family = "Roboto"),
    panel.background = element_rect(fill = "transparent"),
    panel.grid.major.y = element_line(colour = "gray90"),
    panel.grid.major.x = element_line(colour = "gray85"),
    panel.grid.minor.x = element_line(colour = "gray90"),
    legend.position = "none",
    axis.line = element_blank(),
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 9)
  )
  plot <- plot + scale_fill_gradient(low = "springgreen", 
                                     high = "springgreen4")
  
  plot
}

.format_polar <- function(plot) {
  # Create a polar bar chart from the data
  plot <- plot + geom_bar(stat = "identity", width = 1, colour = "white")
  plot <- plot + coord_polar(start = -pi / 24)
  
  # Format chart axes
  plot <- plot + scale_x_continuous(n.breaks = 12)
  plot <- plot + scale_y_continuous(n.breaks = 5)
  
  .format_common(plot)
}

.format_bar <- function(plot) {
  # Create a polar bar chart from the data
  plot <- plot + geom_bar(stat = "identity", width = 1, colour = "white")
  
  # Format chart axes and style
  plot <- plot + scale_x_continuous(n.breaks = 9)
  plot <- plot + scale_y_continuous(n.breaks = 5)
  
  .format_common(plot)
}

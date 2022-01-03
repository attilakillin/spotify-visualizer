library("patchwork")

.font = "Roboto"

# Create a composite plot from different hourly plots
plot_hourly <- function(data, year, color) {
  format <- function(plot) {
    plot +
      xlab("Hour of day") +
      ylab("Minutes listened (per day)") +
      scale_fill_gradient(low = paste(color, "1"), high = paste(color, "4")) +
      theme(
        text = element_text(family = .font),
        panel.background = element_rect(fill = "transparent"),
        panel.grid.major.y = element_line(colour = "gray90"),
        panel.grid.major.x = element_line(colour = "gray85"),
        panel.grid.minor.x = element_line(colour = "gray90"),
        legend.position = "none",
        axis.text = element_text(size = 7),
        axis.title = element_text(size = 8)
      )
  }
  
  left <- format(plot_hourly_polar(data))
  right <- format(plot_hourly_bar(data))
  
  (left | right) +
    plot_annotation(
      title = paste("Hourly distribution of listening time during", year),
      subtitle = "Average listening time (in minutes) in each hour of an average day",
      theme = theme(
        plot.title = element_text(family = .font, hjust = 0.5, size = 12),
        plot.subtitle = element_text(family = .font, hjust = 0.5, size = 9)
      )
    )
}

# Create a composite plot from different daily plots
plot_daily <- function(data, year, color) {
  format <- function(plot) {
    plot +
      xlab(NULL) + ylab(NULL) +
      scale_fill_gradientn(
        colours = c("gray90", paste(color, "1"), paste(color, "4")),
        values = c(0, 0.01, 1)
      ) +
      theme(
        text = element_text(family = .font),
        plot.caption = element_text(
          face = "italic", colour = "gray50", size = 8, hjust = 0.95
        ),
        panel.background = element_rect(fill = "transparent"),
        legend.position = "none",
        axis.text = element_text(size = 7),
        axis.title = element_text(size = 9)
      )
  }
  
  left <- format(plot_daily_waffle(data)) +
    labs(caption = "Darker colors mean higher values") +
    theme(
      panel.grid = element_blank()
    )
  right <- format(plot_daily_bar(data)) +
    labs(caption = "Rolling average is calculated over 15 days") +
    ylab("Minutes listened") +
    theme(
      panel.grid.major.y = element_line(colour = "gray90"),
      panel.grid.major.x = element_line(colour = "gray85"),
      panel.grid.minor.x = element_line(colour = "gray90"),
    )
  
  (left / right) + 
    plot_layout(heights = c(0.6, 1)) +
    plot_annotation(
      title = paste("Daily distribution of listening time during", year),
      subtitle = "Total listening time (in minutes) on each day of the year",
      theme = theme(
        plot.title = element_text(family = .font, hjust = 0.5, size = 12),
        plot.subtitle = element_text(family = .font, hjust = 0.5, size = 9)
      )
    )
}

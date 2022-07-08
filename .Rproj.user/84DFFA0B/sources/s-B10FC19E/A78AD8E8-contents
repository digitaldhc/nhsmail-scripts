# SET COMMON VARIABLES ----

# set working directory where the mailbox report can be found
setwd("c:/b")

# set file path where you want to keep time series data as a CSV
# you may want this to be somewhere that gets backed up
timeseriesloc <- "j:/MFAstatusTimeSeries.csv"

# Install the pacman package to call all the other packages
if (!require("pacman")) install.packages("pacman")

# Use pacman to install (if req) and load required packages
pacman::p_load(
  tidyverse,
  zoo,
  data.table,
  utils,
  lubridate,
  ggthemes,
  ggtext
)

# IMPORT DATASETS ----

# Import the NHSmail mailbox report from your working directory
df <- read.csv(file(timeseriesloc))

# PROCESS DATA ----

# define the date format
df$date = as.Date(df$date, "%Y-%m-%d")


# PLOT DATA ----

# create the plot
df_plot <- ggplot() +
  # plot line data
  geom_line(data = df, aes(x = date, y = n, group = MFAStatus, colour = MFAStatus), size = 2) +
  # set scales
  scale_x_date(date_labels = "%d %b %y") +
  scale_colour_discrete("MFA status") +
  # set axis labels
  xlab("Date") +
  ylab("NHSmail accounts") +
  ggtitle("The uptake of NHSmail multi factor authentication at Dorset HealthCare") +
  # set theme
  theme_base() +
  theme(
    axis.text.x = element_text(size = 8),
    axis.text.y = element_text(size = 8),
    plot.title = element_text(size = 20, family = "Helvetica", face = "bold"),
    plot.subtitle = element_markdown(hjust = 0, vjust = 0, size = 11),
    plot.caption = element_text(size = 8),
    legend.text = element_text(size = 12),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 8),
    strip.text.y = element_text(size = 9.5))

df_plot

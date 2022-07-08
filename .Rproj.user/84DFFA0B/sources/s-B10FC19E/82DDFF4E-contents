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
  lubridate
)

# IMPORT DATASETS ----

# Import the NHSmail mailbox report from your working directory
df <- read.csv(file("Mailbox Report.csv"))

# PROCESS DATA ----

# Filter only active user mailboxes
df <- df %>%
  filter(Status == "Active" & MailboxType == "User")

# Create a second dataframe to count occurrences of the text in 
# the MFAStatus column in the mailbox report
df_mfagrp2 <- df %>%
  count(MFAStatus)

# Remove new mailboxes with blank status
df_mfagrp2 <- df_mfagrp2[!(df_mfagrp2$MFAStatus==""), ]

# Set today's date
date_import <- today()

# Add a new column named 'date' and populate it with the value of date_import
df_mfagrp2['date']= date_import

# MERGE DATA ----

if (!file.exists(timeseriesloc)) {
  write.csv(df_mfagrp2, file = timeseriesloc, row.names = FALSE)
} else {

# Import existing data
df_previous <- read.csv(file = timeseriesloc)

# Merge the two datasets
df_merged <- rbind(df_mfagrp2, df_previous)

# Save the resulting dataset back to the monthly file
write.csv(df_merged, file = timeseriesloc, row.names = FALSE)
}



# pie(df_mfagrp2$n, labels = df_mfagrp2$MFAStatus, radius = 1)

# barplot(height = df_mfagrp2$n, 
#        names = df_mfagrp2$MFAStatus, 
#        horiz = TRUE, las = 1, 
#        cex.names = 0.70,
#        main = "Dorset HealthCare MFA status",
#        xlab = "Mailboxes")


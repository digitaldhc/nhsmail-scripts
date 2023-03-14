# SET COMMON VARIABLES ----

# set working directory where the mailbox report can be found
setwd("c:/github/nhsmail-scripts")

# set file path where you want to keep time series data as a CSV
# you may want this to be somewhere that gets backed up
timeseriesloc <- "j:/MFAstatusTimeSeries2023.csv"

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

# Import the NHSmail mailbox report from your data sub-directory
df_mbr <- read.csv(file("data_temp/Mailbox Report.csv"))

# Import the NHSmail MFA status report from your data sub-directory
df_mfr <- read.csv(file("data_temp/MFAStatusReport.csv"))

# PROCESS DATA ----

# Filter mailbox report for active user mailboxes
df_mbr <- df_mbr %>%
  filter(Status == "Active" & MailboxType == "User")

df_work <- subset(df_mbr, select = c("EmailAddress"))

# get the MFA status for each user from the MFA report
df_work$MFAStatus <- with(df_mfr, MFAStatus[match(df_work$EmailAddress, EmailAddress)])

# Create a second dataframe to count occurrences of the text in 
# the MFAStatus column in the mailbox report
df_work_grouped <- df_work %>%
  count(MFAStatus)

# Set today's date
date_import <- today()

# Add a new column named 'date' and populate it with the value of date_import
df_work_grouped['date']= date_import

# MERGE DATA ----

if (!file.exists(timeseriesloc)) {
  write.csv(df_work_grouped, file = timeseriesloc, row.names = FALSE)
} else {
  
  # Import existing data
  df_previous <- read.csv(file = timeseriesloc)
  
  # Merge the two datasets
  df_merged <- rbind(df_work_grouped, df_previous)
  
  # Save the resulting dataset back to the monthly file
  write.csv(df_merged, file = timeseriesloc, row.names = FALSE)
}

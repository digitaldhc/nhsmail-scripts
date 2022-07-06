# SET COMMON VARIABLES ----

# set working directory
setwd("~/Documents/Work/mailboxr")

# Install the pacman package to call all the other packages
if (!require("pacman")) install.packages("pacman")

# Use pacman to install (if req) and load required packages
pacman::p_load(
  httr,
  readxl,
  readODS,
  tidyverse,
  zoo,
  data.table,
  scales,
  glue,
  ggtext,
  ggthemes,
  pals,
  utils,
  reshape,
  lubridate,
  rvest,
  stringr,
  openxlsx,
  ggalt,
  janitor
)

# IMPORT DATASETS ----

df <- read.csv(file("Mailbox Report.csv"))

df <- df %>%
  filter(Status == "Active")

df_mfagrp <- table(df$MFAStatus)

df_mfagrp2 <- df %>%
  count(MFAStatus)

df_mfagrp2 <- tail(df_mfagrp2,3)

pie(df_mfagrp2$n, labels = df_mfagrp2$MFAStatus, radius = 1)

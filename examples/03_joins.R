# Example 3 — combining tables: left_join() and inner_join()
#
# Our data is spread across files:
#   behaviour -> video_view.csv, user_view.csv, watch_events.csv
#   context   -> creators.csv, videos.csv, users.csv, sessions.csv
#
# Joins put them back together.

library(tidyverse)

video_view   <- read_csv("data/video_view.csv")
creators     <- read_csv("data/creators.csv")
impressions  <- read_csv("data/impressions.csv")
watch_events <- read_csv("data/watch_events.csv")

# left_join(): keep every row of the left table, add columns from the right
# where the key matches. Unmatched rows get NA.
video_with_creators <- video_view %>%
  left_join(creators, by = "creator_id")

# inner_join(): keep only rows that matched in BOTH tables.
# Here that means only impressions that were actually watched.
watched_only <- impressions %>%
  inner_join(watch_events, by = "impression_id")

# The row-count check. Do this every time you join something important.
nrow(video_view)          # before
nrow(video_with_creators) # after a left_join: should be identical

nrow(impressions)   # before
nrow(watched_only)  # after an inner_join: should be smaller

# If a left_join makes your table *grow*, the key is not unique on the right
# side and rows are being duplicated. That is the most common join bug, and it
# is silent — nothing errors, your numbers are just quietly wrong.
#
# Keys can be single or composite:
#   by = "creator_id"                   one column
#   by = c("video_id", "creator_id")    two columns, matched together
#
# Default choice in data prep: start with left_join().

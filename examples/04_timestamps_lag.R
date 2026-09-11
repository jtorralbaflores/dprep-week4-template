# Example 4 — timestamps and lagged metrics
#
# Requires watch_log, which you build in Exercise 4. Run this after that
# exercise works, or adapt it to the impressions table to try the pattern out.

library(tidyverse)

impressions <- read_csv("data/impressions.csv")

# --- Step 1: conversion -----------------------------------------------------
#
# shown_at arrives as text: "2025-08-01T21:44:48Z"
# Text cannot be compared, sorted by time, or aggregated by day.

time_preview <- impressions %>%
  mutate(
    shown_ts  = as.POSIXct(shown_at,
                           format = "%Y-%m-%dT%H:%M:%SZ",
                           tz     = "UTC"),
    shown_day = as.Date(shown_ts)
  ) %>%
  select(impression_id, creator_id, shown_at, shown_ts, shown_day) %>%
  head(8)

time_preview

# Two conversions, two purposes:
#   shown_at  is character -> useless for time arithmetic
#   shown_ts  is POSIXct   -> a real moment in time
#   shown_day is Date      -> the grouping level for "per creator per day"
#
# Confirm it worked. If the format string does not match the data exactly,
# as.POSIXct() returns NA silently rather than failing:
class(time_preview$shown_ts)
sum(is.na(time_preview$shown_ts))   # should be 0

# --- Step 2: daily counts and a lag ----------------------------------------

creator_daily <- impressions %>%
  mutate(shown_ts  = as.POSIXct(shown_at,
                                format = "%Y-%m-%dT%H:%M:%SZ",
                                tz     = "UTC")) %>%
  mutate(shown_day = as.Date(shown_ts)) %>%
  count(creator_id, shown_day, name = "impressions_n") %>%
  group_by(creator_id) %>%
  arrange(shown_day) %>%
  mutate(impressions_lag1 = lag(impressions_n))

creator_daily %>% head(10)

# lag() takes the value from the previous row. That only means "yesterday"
# if the rows are sorted by day AND grouped by creator — otherwise you pick up
# the previous creator's last day. Note the order: group_by, then arrange,
# then lag.
#
# The first day of each creator has no previous day, so its lag is NA.
# That is correct, not a bug to patch away.

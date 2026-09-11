# =============================================================================
# Week 4 — Data engineering (Exercises 1 to 5)
#
# Branch: feature/week4-data      This becomes PR1.
#
# Follow the slides. Each exercise below matches a "WORK TIME" slide.
# The questions in the comments are the hints — read them before asking.
# =============================================================================

# ---- SETUP ------------------------------------------------------------------

library(tidyverse)

# ---- INPUT ------------------------------------------------------------------

video_view   <- read_csv("data/video_view.csv")
user_view    <- read_csv("data/user_view.csv")
videos       <- read_csv("data/videos.csv")
creators     <- read_csv("data/creators.csv")
users        <- read_csv("data/users.csv")
impressions  <- read_csv("data/impressions.csv")
watch_events <- read_csv("data/watch_events.csv")
sessions     <- read_csv("data/sessions.csv")


# ---- TRANSFORM --------------------------------------------------------------

# =============================================================================
# Exercise 1 — video_features
# Slide: "WORK TIME - Exercise 1"        Example: examples/01_rank_distinct.R
# =============================================================================
#
# Build one row per video, carrying a rank, a reach band, and a quality flag.
#
#   ? The example ranks with rank(-watch_rate). Why the minus sign?
#   ? reach_band turns one numeric column (impressions_n) into three labels:
#     "Low", "Medium", "High". Which dplyr verb maps number ranges to labels?
#     It is not in the example — check your week 3 notes or the dplyr docs.
#   ? high_quality is TRUE/FALSE. What does avg_watch_share >= 0.40 return
#     on its own, before you put it inside mutate()?
#   ? Does distinct() belong before or after mutate()? Try it the other way
#     and look at the row count.

video_features <- video_view %>%
  # your code here

# Show the 10 best videos, sorted by rank:
# your code here

# ---- OUTPUT -----------------------------------------------------------------
# write_csv(video_features, "temp/video_features.csv")


# -----------------------------------------------------------------------------
# GIT CHECKPOINT A1 — commit before moving on
#
#   git status
#   git add src/data_engineering.R
#   git commit -m "Add video features with mutate rank and distinct"
#   git status
# -----------------------------------------------------------------------------


# =============================================================================
# Exercise 2 — creator_summary and engagement_by_band
# Slide: "WORK TIME - Exercise 2"        Example: examples/02_aggregation.R
# =============================================================================
#
# Two aggregate tables, both built from video_features.
#
# creator_summary needs: videos_n, impressions_total, watched_total,
#                        avg_watch_rate, median_watch_seconds
# engagement_by_band needs: number of videos, average watch rate
#
#   ? videos_n is a count of rows in each group. Which function inside
#     summarise() gives you that, with no arguments?
#   ? What happens to avg_watch_rate if one video has a missing watch_rate
#     and you forget na.rm = TRUE?
#   ? engagement_by_band groups by a column you created in Exercise 1, not one
#     that came from the CSV. Does that work? Why?
#   ? Sort creator_summary by desc(impressions_total).

creator_summary <- video_features %>%
  # your code here

engagement_by_band <- video_features %>%
  # your code here

# ---- OUTPUT -----------------------------------------------------------------
# write_csv(creator_summary,    "temp/creator_summary.csv")
# write_csv(engagement_by_band, "temp/engagement_by_band.csv")


# -----------------------------------------------------------------------------
# GIT CHECKPOINT A2
#
#   git add src/data_engineering.R
#   git commit -m "Add creator and reach-band aggregations"
# -----------------------------------------------------------------------------


# =============================================================================
# Exercise 3 — video_enriched and user_enriched
# Slide: "WORK TIME - Exercise 3"        Example: examples/03_joins.R
# =============================================================================
#
# video_enriched: start from video_features, join videos, then creators.
#   Keep: video_id, creator_id, creator_name, impressions_n, watch_rate,
#         watch_rate_rank, quality, posting_rate, publish_time
#
#   ? The join to videos uses TWO key columns, the join to creators uses one.
#     Why the difference? What would go wrong joining videos on video_id alone?
#   ? Record nrow(video_features) before you join. Compare after each step.
#     If the number grew, stop and work out which side has repeated keys.
#   ? Why left_join here rather than inner_join? What would you lose?

video_enriched <- video_features %>%
  # your code here

# user_enriched: start from user_view, join users.
#   Keep the user watch KPIs and the profile columns you find useful.
#
#   ? Run names(user_view) and names(users) first. Which columns overlap?
#     What does dplyr do to a non-key column that exists in both tables?

user_enriched <- user_view %>%
  # your code here

# ---- OUTPUT -----------------------------------------------------------------
# write_csv(video_enriched, "temp/video_enriched.csv")
# write_csv(user_enriched,  "temp/user_enriched.csv")


# =============================================================================
# Exercise 4 — watch_log and creator_event_summary
# Slide: "WORK TIME - Exercise 4"        Example: examples/03_joins.R
# =============================================================================
#
# watch_log chains four joins onto impressions:
#   watch_events by impression_id
#   sessions     by session_id + user_id
#   videos       by video_id + creator_id
#   creators     by creator_id
#
#   ? Build this ONE join at a time, checking nrow() after each. Do not write
#     all four and hope. When the count jumps, you want to know which join did it.
#   ? impressions has more rows than watch_events. After the first left_join,
#     which columns are NA, and what does an NA mean here in plain words?

watch_log <- impressions %>%
  # your code here

# watched_only: the inner_join version, for comparison.
#
#   ? How many rows does this lose versus watch_log, and what are those rows?

watched_only <- impressions %>%
  # your code here

# creator_event_summary needs: impressions, watched events, total watch seconds
#
#   ? "Watched events" means rows where a watch actually happened. After a
#     left_join, how do you count only the non-missing ones? Think about what
#     sum() does to a TRUE/FALSE column.

creator_event_summary <- watch_log %>%
  # your code here

# ---- OUTPUT -----------------------------------------------------------------
# write_csv(watch_log,             "temp/watch_log.csv")
# write_csv(creator_event_summary, "temp/creator_event_summary.csv")


# -----------------------------------------------------------------------------
# GIT CHECKPOINT A3
#
#   git add src/data_engineering.R
#   git commit -m "Add join workflows for view and event data"
# -----------------------------------------------------------------------------


# =============================================================================
# Exercise 5 — creator_daily with a lag
# Slide: "WORK TIME - Exercise 5"        Example: examples/04_timestamps_lag.R
# =============================================================================
#
# From watch_log: convert the timestamp, aggregate per creator per day, then
# add impressions_lag1 and impressions_change.
#
#   ? Convert shown_at to shown_ts, then shown_ts to shown_day. Why two steps
#     rather than straight from text to Date?
#   ? Check your conversion worked: sum(is.na(...)) on the new column. A
#     mismatched format string gives you NA silently, not an error.
#   ? lag() reads the row above. What has to be true about row order and
#     grouping for that row to really be "the day before, same creator"?
#   ? The first day of each creator gets NA for the lag. Is that a problem
#     to fix, or the correct answer?

creator_daily <- watch_log %>%
  # your code here

# ---- OUTPUT -----------------------------------------------------------------
# write_csv(creator_daily, "temp/creator_daily_week4.csv")


# -----------------------------------------------------------------------------
# GIT CHECKPOINT A4 — then push and open PR1
#
#   git add src/data_engineering.R
#   git commit -m "Add timestamp conversion and lagged daily metrics"
#   git log --oneline --graph -10
#   git push -u origin feature/week4-data
#
# Before you open the PR, read your own log. Does the sequence of commit
# messages tell someone what you did, in order, without opening the diff?
# -----------------------------------------------------------------------------

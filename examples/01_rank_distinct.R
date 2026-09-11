# Example 1 — creating variables: mutate(), rank(), distinct()
#
# Read this, run it, then look at the result. You will apply the same pattern
# in Exercise 1.

library(tidyverse)

video_view <- read_csv("data/video_view.csv")

# mutate() adds columns. rank() turns a numeric column into a position.
# distinct() keeps one row per video.
video_simple <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate),
    high_quality    = avg_watch_share >= 0.40
  ) %>%
  distinct(video_id, .keep_all = TRUE)

video_simple %>%
  select(video_id, creator_id, watch_rate, watch_rate_rank, high_quality) %>%
  head(10)

# Note the minus sign in rank(-watch_rate).
# rank() counts upwards: the smallest value gets rank 1. We want the *best*
# video to be rank 1, so we flip the sign first.

# Once the simple version makes sense, you can control ties and missing values:
video_ranked <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate,
                           na.last      = "keep",
                           ties.method  = "min")
  )

# na.last = "keep"   -> missing values stay missing instead of being ranked
# ties.method = "min" -> two tied videos both get the better rank
#
# Use this refinement only after the simple version works.

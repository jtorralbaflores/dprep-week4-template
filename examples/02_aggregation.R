# Example 2 — aggregation: group_by(), summarise(), arrange()
#
# Aggregation means going from many rows to fewer summary rows.
# Here: roughly 1200 video rows become about 60 creator rows.

library(tidyverse)

video_view <- read_csv("data/video_view.csv")

creator_example <- video_view %>%
  group_by(creator_id) %>%
  summarise(
    impressions_total = sum(impressions_n, na.rm = TRUE),
    avg_watch_rate    = mean(watch_rate, na.rm = TRUE)
  ) %>%
  arrange(desc(impressions_total))

creator_example %>% head(10)

# Check what aggregation actually did:
nrow(video_view)      # rows in, one per video
nrow(creator_example) # rows out, one per creator

# Three things worth noticing:
#
# 1. group_by() alone changes nothing visible. It marks the groups.
#    summarise() is what collapses the rows.
#
# 2. na.rm = TRUE tells the summary function to ignore missing values.
#    Without it, a single NA makes the whole sum or mean NA.
#
# 3. summarise() keeps only the grouping column and what you create.
#    Every other column is dropped. That is the point of a summary.

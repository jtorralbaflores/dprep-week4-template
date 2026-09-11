# Example 2

library(tidyverse)

video_view <- read_csv("data/video_view.csv")

creator_example <- video_view %>%
  group_by(creator_id) %>%
  summarise(
    impressions_total = sum(impressions_n, na.rm = TRUE),
    avg_watch_rate = mean(watch_rate, na.rm = TRUE)
  ) %>%
  arrange(desc(impressions_total))

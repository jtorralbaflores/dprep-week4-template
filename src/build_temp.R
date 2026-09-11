# =============================================================================
# Exercise 6a — build the intermediate creator table
# Slide: "WORK TIME - Exercise 6"
#
# Branch: feature/week4-make      This becomes PR2.
#
# This script is one step in a pipeline. Make will run it for you, so it has to
# work start-to-finish on its own, with no leftovers in your R session.
#
#   ? Restart R before you test this (Session > Restart R). If it only works
#     because something is already in memory, Make will fail and you will not
#     understand why.
#
# Structure: Setup - Input - Transform - Output. Keep the sections in order.
# =============================================================================

# ---- SETUP ------------------------------------------------------------------

library(tidyverse)

dir.create("temp", showWarnings = FALSE)

#   ? Why create the folder here rather than assuming it exists? Think about
#     someone cloning your repo — temp/ is gitignored, so what do they have?

# ---- INPUT ------------------------------------------------------------------

# Read data/video_view.csv and data/creators.csv
# your code here


# ---- TRANSFORM --------------------------------------------------------------

# Aggregate to creator level: videos_n, impressions_total, watched_total,
# avg_watch_rate. Then attach the creator details.
#
#   ? You wrote something close to this in Exercise 2. What is different here,
#     and what can you reuse?
#   ? Does the join come before or after the summarise? Both run. Which is
#     cheaper, and does it change the answer?

creator_week4 <- # your code here


# ---- OUTPUT -----------------------------------------------------------------

# Write to temp/creator_week4.csv
# your code here

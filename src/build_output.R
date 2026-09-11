# =============================================================================
# Exercise 6b — build the final output table
# Slide: "WORK TIME - Exercise 6"
#
# Branch: feature/week4-make      This becomes PR2.
#
# The second step of the pipeline. Its input is the OUTPUT of build_temp.R —
# it reads from temp/, not from data/.
#
#   ? That dependency is the whole reason Make exists. If build_temp.R changes,
#     what has to happen to this script's output, and how would Make know?
# =============================================================================

# ---- SETUP ------------------------------------------------------------------

library(tidyverse)

dir.create("output", showWarnings = FALSE)

# ---- INPUT ------------------------------------------------------------------

# Read temp/creator_week4.csv
# your code here


# ---- TRANSFORM --------------------------------------------------------------

# Keep the top 10 creators by impressions.
#
#   ? Sort first, then take the top rows. Which two verbs, in which order?
#   ? head(10) and slice_head(n = 10) both work here. One of them behaves
#     differently on a grouped table — which, and does that matter for you?

creator_top10_week4 <- # your code here


# ---- OUTPUT -----------------------------------------------------------------

# Write to output/creator_top10_week4.csv
# your code here


# -----------------------------------------------------------------------------
# GIT CHECKPOINT B1 — commit both build scripts together
#
#   git status
#   git add src/build_temp.R src/build_output.R
#   git commit -m "Add build scripts for temp and output tables"
#   git status
#
# Test both scripts by hand before you write the makefile:
#
#   Rscript src/build_temp.R
#   Rscript src/build_output.R
#
# Make cannot fix a broken script. Get them working first.
# -----------------------------------------------------------------------------

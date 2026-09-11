# Downloads the raw data for the week 4 tutorial into data/.
#
# Run once:  source("download_data.R")
#
# Already-downloaded files are skipped, so it is safe to run again.

library(tidyverse)

dir.create("data", showWarnings = FALSE)

base_url <- paste0(
  "https://raw.githubusercontent.com/hannesdatta/",
  "course-dprep/refs/heads/main/material/project/"
)

files <- c(
  "video_view.csv",
  "coaching_2_data/impressions.csv",
  "coaching_2_data/watch_events.csv",
  "coaching_2_data/sessions.csv",
  "coaching_2_data/users.csv"
)

# ---------------------------------------------------------------------------
# TODO (instructor): three files are not published yet.
#
#   creators.csv, videos.csv, user_view.csv
#
# They are needed by Exercises 2, 3, 4 and 6. Add their URLs here once
# available, then delete this block and the warning at the bottom.
# ---------------------------------------------------------------------------

for (f in files) {
  dest <- file.path("data", basename(f))
  if (file.exists(dest)) {
    message("already have: ", basename(f))
  } else {
    message("downloading:  ", basename(f))
    download.file(paste0(base_url, f), dest, mode = "wb", quiet = TRUE)
  }
}

message("\nDone. Files in data/:")
print(list.files("data"))

pending <- c("creators.csv", "videos.csv", "user_view.csv")
missing <- setdiff(pending, list.files("data"))
if (length(missing) > 0) {
  warning(
    "Not published yet: ", paste(missing, collapse = ", "),
    "\nExercises 2, 3, 4 and 6 need these. Your instructor will post them.",
    call. = FALSE
  )
}

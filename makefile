# =============================================================================
# Exercise 7 — the build recipe
# Slide: "WORK TIME - Exercise 7"
#
# A rule has three parts:
#
#   target: prerequisites
#   <TAB>command that builds the target
#
#   target        the file to create
#   prerequisites the files it needs first
#   command       how to build it
#
# The command line MUST start with a real tab, not spaces. This is the single
# most common Make error. If you see "missing separator", that is what happened
# — your editor inserted spaces.
# =============================================================================


# 'all' is the default entry point: plain `make` builds this target.
#
#   ? Only the FINAL output is listed here, not the intermediate one.
#     How does Make know it still has to build temp/creator_week4.csv first?

all: output/creator_top10_week4.csv


# ---- Rule 1: raw data -> temp -----------------------------------------------
#
# Target:        temp/creator_week4.csv
# Prerequisites: the script that makes it, plus the data files it reads
# Command:       Rscript src/build_temp.R
#
#   ? Why list the .R script as a prerequisite and not just the data? What
#     should happen when you edit the script but the data has not changed?

# your rule here


# ---- Rule 2: temp -> output --------------------------------------------------
#
# Target:        output/creator_top10_week4.csv
# Prerequisites: its script, and the temp file from Rule 1
# Command:       Rscript src/build_output.R
#
#   ? Rule 1's target is Rule 2's prerequisite. That link is what lets Make
#     work out the order by itself — you never tell it which runs first.

# your rule here


# ---- clean: remove everything that can be rebuilt ----------------------------
#
# This one is written for you. Copy its shape for the rules above — note the
# tab at the start of the command line.
#
#   ? clean deletes temp/ and output/ but never touches data/ or src/.
#     What is the rule for deciding what belongs in a clean target?

clean:
	rm -f temp/*.csv output/*.csv


# =============================================================================
# Run these in order and watch what happens:
#
#   make -n      dry run: shows the commands WITHOUT running them. Always
#                start here. Does the order match what you expected?
#   make         builds everything
#   make         run it a second time. Almost nothing should happen. Why?
#   make clean   removes the generated files
#   make         rebuilds from scratch
#
#   ? Between the first and second `make`, nothing changed on disk. How does
#     Make decide a target is already up to date? What is it comparing?
#
# Now try: open src/build_temp.R, save it without editing anything, run `make`
# again. Does it rebuild? What does that tell you about what Make looks at?
#
# -----------------------------------------------------------------------------
# GIT CHECKPOINT B2 — then push and open PR2
#
#   git status
#   git add makefile
#   git commit -m "Add make workflow with clean target"
#   git log --oneline --graph -10
#   git push -u origin feature/week4-make
# =============================================================================

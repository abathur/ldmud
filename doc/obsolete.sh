#!/bin/bash
# Generate a directory of doc files that have gone missing since the primary argument (i.e., ... ./obsolete.sh 3.3.700 recovers documents from 3.3.700 to the HEAD of your current branch.)
#
rm -rf doc/removed
mkdir doc/removed
# -1 = no compression; we're immediately unpacking anyways
git archive $1 $(git diff --name-only --diff-filter=D $1 HEAD -- doc/) | tar -x -C doc/removed --strip-components=1 # 1=re-gen the nested folders, 2=flat
# the diff command above was:
# git diff-tree --no-commit-id --name-only --diff-filter=D -r $1 HEAD -- doc/

echo "This directory contains docs removed between $1 and $(git describe HEAD)" > doc/removed/README.md

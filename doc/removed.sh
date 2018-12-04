#!/bin/bash
#
# Generate a markdown list of all files that have been removed from the repo at some point.
#
# Next to each file, print a list of tag-relative commits that removed them, and link to the parent (previous) commit (the last commit the file was present at).
#
# NOTE: by "tag-relative" I mean that these aren't strictly equivalent with release tags--they're release tags along with a relative commit indicator. Something like 3.2.9~1 means "one commit before tag 3.2.9"
DOCDIR=$(dirname "$0")

# we don't wanna generate this all the time if we don't need to
# check 1: does removed.md exist?
if [ -f "$DOCDIR/REMOVED.md" ]; then
	exit
	# TODO: we want a better check actually. Ideally, we'd regen if we've deleted a doc since we last updated the removed doc.
fi

(
	echo "# Removed docs"
	echo "The table below lists documents no longer present in the LDMud source and links to copies in the git history."
	echo ""
	printf "%-40s | %s \n" "Original File" "Previous versions"
	echo "---------------------------------------- | -----------------"

	for file in $(git log --pretty=format: --all --name-only --relative=doc/ -- doc/* | sort -uf); do
		# we only care about missing files
		if [ ! -f "$DOCDIR/$file" ]; then
			# have to generate links with the commit hash and text with a tag
			# two approaches: explicitly do each, or generate the whole thing with a short hash and a long hash and then run it through name-rev
			printf "%-40s | $(git log --format="[%H](blob/%p/doc/$file)" --all --diff-filter=D -- doc/$file | git name-rev --tags --name-only --stdin | sort -g | tr '\n' ' ')" "$file"
			#printf "[long-hash](blob/short-hash)"
			printf "\n"
		fi
	done
) > "$DOCDIR/REMOVED.md"

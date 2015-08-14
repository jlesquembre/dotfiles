#!/bin/bash

logformat="format:- %s [%an]%+b%n"

lasttag=$(git rev-list --tags --max-count=1 2>/dev/null)


if [ $? -eq 0 ]; then
    git log --no-merges --pretty="$logformat" --since="$(git show -s --format=%ad $lasttag)"
else
    git log --no-merges --pretty="$logformat"
fi

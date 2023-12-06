#!/bin/bash

# if .build/debug/aoc-cli doesn't exist, build it
[ -f .build/debug/aoc-cli ] || swift build --target AdventOfCodeCLI

day=$(ls Sources/AdventOfCode2023 | grep -E 'Day[0-9]+.swift' | tail -1 | grep -oE '[0-9]+')
for ((i=1; i<=day; i++)); do
    echo "Fetching day $i input..."
    .build/debug/aoc-cli fetch -d $i
done

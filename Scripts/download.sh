#!/bin/bash

day=$(ls Sources/AdventOfCode2023 | grep -E 'Day[0-9]+.swift' | tail -1 | grep -oE '[0-9]+')
for ((i=1; i<=day; i++)); do
    echo "Fetching day $i input..."
    wget --no-check-certificate \
        --header="Cookie: session=$AOC_SESSION" \
        -O "Sources/AdventOfCode2023/Inputs/day$i.txt" \
        "https://adventofcode.com/2023/day/$i/input" \
        -q
done
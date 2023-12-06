#!/bin/bash

day=$(ls Sources/AdventOfCode2023 | grep -E 'Day[0-9]+.swift' | tail -1 | grep -oE '[0-9]+')
for ((i=1; i<=day; i++)); do
    echo "Fetching day $i input..."
    swift run aoc-cli fetch -d $i
done

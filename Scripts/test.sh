#!/bin/sh

day=$1

# run swift tests matching the day
swift test --disable-xctest --enable-experimental-swift-testing --parallel --filter "AdventOfCode2023Tests.Day($day)"

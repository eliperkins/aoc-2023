#!/bin/sh

day=$1

# run swift tests matching the day
swift test --enable-experimental-swift-testing --filter "AdventOfCode2023Tests.Day($day)"

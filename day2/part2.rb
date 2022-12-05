#!/usr/bin/env ruby

SCORES = {
  # Rock Rock
  "A X" => 3+1,
  # Rock Paper
  "A Y" => 6+2,
  # Rock Scissors
  "A Z" => 0+3,
  # Paper Rock
  "B X" => 0+1,
  # Paper Paper
  "B Y" => 3+2,
  # Paper Scissors
  "B Z" => 6+3,
  # Scissors Rock
  "C X" => 6+1,
  # Scissors Paper
  "C Y" => 0+2,
  # Scissors Scissors
  "C Z" => 3+3,
}

p File.read(ARGV.last).split("\n").map { |v| SCORES.fetch(v) }.reduce(:+)

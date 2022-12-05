#!/usr/bin/env ruby

# shape you selected (1 for Rock, 2 for Paper, and 3 for Scissors)
# outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won)
SCORES = {
  # Rock lose (Scissors)
  "A X" => 0+3,
  # Rock draw (Rock)
  "A Y" => 3+1,
  # Rock win (Paper)
  "A Z" => 6+2,
  # Paper lose (Rock)
  "B X" => 0+1,
  # Paper draw (Paper)
  "B Y" => 3+2,
  # Paper win (Scissors)
  "B Z" => 6+3,
  # Scissors lose (Paper)
  "C X" => 0+2,
  # Scissors draw (Scissors)
  "C Y" => 3+3,
  # Scissors win (Rock)
  "C Z" => 6+1,
}

p File.read(ARGV.last).split("\n").map { |v| SCORES.fetch(v) }.reduce(:+)

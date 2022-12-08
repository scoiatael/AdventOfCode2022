#!/usr/bin/env ruby

DATA = File.read(ARGV.last).split.map { |r| r.split("").map(&:to_i) }
ROWS = DATA.size
COLS = DATA.first.size

def visible(line, max)
  num = line.take_while { |c| c < max }.size
  return num if num == line.size
  num+1
end


r = []
ROWS.times.map do |idy|
  COLS.times.map do |idx|
    left = DATA[idy][...idx].reverse
    right = DATA[idy][(idx+1)..]
    up = (0...idy).map { |y| DATA[y][idx] }.reverse
    down = ((idy+1)...COLS).map { |y| DATA[y][idx] }
    current = DATA[idy][idx]

    r << [up, left, right, down].map { |line| visible(line, current) }.reduce(:*)
  end
end

p r.max

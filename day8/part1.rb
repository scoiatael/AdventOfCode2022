#!/usr/bin/env ruby

DATA = File.read(ARGV.last).split.map { |r| r.split("").map(&:to_i) }
ROWS = DATA.size
COLS = DATA.first.size

def visible(line)
  max = line.first
  visibles = line.each_with_index.filter do |(el, _idx)|
    (el > max).tap do |visible|
        max = el if visible
    end
  end
  [0] + visibles.map(&:last)
end

TREES_VISIBLE = COLS.times.map { ROWS.times.map { "."}.join("") }
def mark_visible(idx, idy)
  TREES_VISIBLE[idy][idx] = "X"
end

DATA.each_with_index.map { |row, idx| visible(row).map { |idy| mark_visible(idy, idx)} }
DATA.each_with_index.map { |row, idx| visible(row.reverse).map { |idy| mark_visible(COLS-idy-1, idx)} }

cols = COLS.times.map { |idx| DATA.map { |row| row[idx] } }
cols.each_with_index.map { |col, idy| visible(col).map { |idx| mark_visible(idy, idx)} }
cols.each_with_index.map { |col, idy| visible(col.reverse).map { |idx| mark_visible(idy, ROWS-idx-1)} }

p TREES_VISIBLE.join("\n").split("").select { |t| t == "X" }.size

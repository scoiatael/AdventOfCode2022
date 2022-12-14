#!/usr/bin/env ruby

heights = File.read(ARGV.last).split("\n").map { |line| line.split("").each_with_index }.each_with_index.map { |line, idy| line.map { |height, idx| [[idx, idy], height.ord] }  }.flatten(1).to_h

START_POINT = heights.find { |_, height| height == 'S'.ord }.first
heights[START_POINT] = 'a'.ord
END_POINT = heights.find { |_, height| height == 'E'.ord }.first
heights[END_POINT] = 'z'.ord

EDGES = Hash.new { |h, k| h[k] = [] }

heights.each do |pos, height|
  idx, idy = pos
  (idx-1..idx+1).each do |tidx|
    (idy-1..idy+1).each do |tidy|
      next if tidx == idx && tidy == idy
      next if tidx != idx && tidy != idy
      tpos = [tidx, tidy]
      next unless heights.include?(tpos)
      theight = heights[tpos]
      next unless theight <= height+1
      EDGES[pos] << tpos
    end
  end
end

require 'set'

def dis(a, b)
  ax, ay = a
  bx, by = b
  dx = ax-bx
  dy = ay-by
  dx*dx+dy*dy
end


MINDISTANCE = heights.select { |_, height| height == 'a'.ord }.map { |point, _| [point, 0] }.to_h
def shortest_from(start_point)
  queue = [start_point]
  visited = Set.new

  from = {}

  loop do
    current = queue.sort_by! { |pos| dis(pos, END_POINT) }.shift
    raise StandardError.new("WTF") unless current
    next if visited.include?(current)
    visited << current
    steps = MINDISTANCE.fetch(current)
    break if current == END_POINT

    EDGES[current].each do |pos|
      MINDISTANCE[pos] = [steps+1, MINDISTANCE[pos]].compact.min
      if MINDISTANCE[pos] == steps+1
        from[pos] = current
        queue << pos
      end
    end
  end

  path = Set.new
  current = END_POINT
  loop do
    current = from[current]
    break unless current
    path << current
  end

  path.size
end

all = heights.select { |_, height| height == 'a'.ord }
p (all.each_with_index.map do |(start_point, _), idx|
  begin
    shortest_from(start_point)
  rescue StandardError
  end
end).compact.min

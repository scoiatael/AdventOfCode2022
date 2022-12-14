#!/usr/bin/env ruby

heights = File.read(ARGV.last).split("\n").map { |line| line.split("").each_with_index }.each_with_index.map { |line, idy| line.map { |height, idx| [[idx, idy], height.ord] }  }.flatten(1).to_h

START_POINT = heights.find { |_, height| height == 'S'.ord }.first
heights[START_POINT] = 'a'.ord
END_POINT = heights.find { |_, height| height == 'E'.ord }.first
heights[END_POINT] = 'z'.ord

edges = Hash.new { |h, k| h[k] = [] }

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
      edges[pos] << tpos
    end
  end
end

 p edges

require 'set'
visited = Set.new
minDistance = {START_POINT => 0}
queue = [START_POINT]

module Color
  class <<self
    # colorization
    def colorize(color_code, sth)
      "\e[#{color_code}m#{sth}\e[0m"
    end

    def visited(x)
      colorize(31, x)
    end

    def current(x)
      colorize(32, x)
    end

    def notVisited(x)
      colorize(33, x)
    end
  end
end


def render_visited(heights, visited, current, path)
  x = heights.keys.map(&:first).max+1
  y = heights.keys.map(&:last).max+1

  y.times do |idy|
    puts (x.times.map do |idx|
      pos = [idx, idy]
      v = heights[pos]
      t = if pos == START_POINT then 'S' else if pos == END_POINT then 'E' else v.chr end end
      next Color.current(t) if  pos == current
      next Color.visited('.') if path.include?(pos)
      next Color.visited(t) if visited.include?(pos)
      Color.notVisited(t)
    end).join("")
  end
  puts "\n\n"
end

def dis(a, b)
  ax, ay = a
  bx, by = b
  dx = ax-bx
  dy = ay-by
  dx*dx+dy*dy
end

from = {}

steps = loop do
  current = queue.sort_by! { |pos| dis(pos, END_POINT) }.shift
  raise Exception.new("WTF") unless current
  next if visited.include?(current)
  visited << current
  # render_visited(heights, visited, current)
  steps = minDistance.fetch(current)
  break steps if current == END_POINT
  edges[current].each do |pos|
    queue << pos
    minDistance[pos] = [steps+1, minDistance[pos]].compact.min
    from[pos] = current if minDistance[pos] == steps+1
  end
end

path = Set.new
current = END_POINT
loop do
  current = from[current]
  break unless current
  path << current
end

render_visited(heights, visited, current, path)

p steps, path.size

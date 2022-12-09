#!/usr/bin/env ruby

require 'set'

def into_coords(inst)
  dir, steps = inst
  val = case dir
  when 'R'
    [1, 0]
  when 'U'
    [0, 1]
  when 'L'
    [-1, 0]
  when 'D'
    [0, -1]
  end
  Enumerator.new do |y|
    steps.times { y << val }
  end
end

def sum_coords(one, two)
  [one.first + two.first, one.last + two.last]
end

def add_delta(one, two, sign=1)
  [one.first + sign*two.first, one.last + sign*two.last]
end

def are_touching(delta)
  x, y = delta
  x*x + y*y <= 2
end

def closer(distance, min)
  sign = (distance <=> 0)
  return distance if sign*distance <= min
  return distance - sign
end

def shorten(delta)
  return delta if are_touching(delta)
  x, y = delta
  return [closer(x, 1), closer(y, 1)] if x == 0 || y == 0
  [closer(x, 0), closer(y, 0)]
end

HEAD_POS = [[0,0]]
TAIL_POS = Set.new([[0,0]])
CUR = [[0,0]]

def step(inst)
  into_coords(inst).each do |delta|
    # puts "---"
    curp = CUR.last
    # p [curp, delta]
    curp = sum_coords(curp, delta)
    headposp = HEAD_POS.last
    headposp = sum_coords(headposp, delta)
    HEAD_POS << headposp
    # p curp
    curp = shorten(curp)
    tailposp  = add_delta(headposp, curp, sign=-1)
    TAIL_POS << tailposp
    # p [headposp, curp, tailposp]
    CUR << curp
    # puts "---"
  end
end


DATA = File.read(ARGV.last).split.each_slice(2).map { |d, s| [d, s.to_i] }
DATA.each(&method(:step))
p TAIL_POS.size

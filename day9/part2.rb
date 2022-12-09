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

def diff_coords(one, two)
  [one.first - two.first, one.last - two.last]
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

POS = [[[0,0]]*10]

def step(inst)
  into_coords(inst).each do |delta|
    head, *tails = POS.last
    # p [head, delta, tails]
    nhead = sum_coords(head, delta)
    npos = [nhead]
    tails.each do |tail|
      curp = diff_coords(nhead, tail)
      curp = shorten(curp)
      ntail =  add_delta(nhead, curp, sign=-1)
      npos << ntail
      nhead = ntail
    end
    # p npos
    POS << npos
  end
end


DATA = File.read(ARGV.last).split.each_slice(2).map { |d, s| [d, s.to_i] }
DATA.each(&method(:step))
p Set.new(POS.map(&:last)).size

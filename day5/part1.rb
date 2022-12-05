#!/usr/bin/env ruby

state, cmds = File.read(ARGV.last).split("\n\n")

cols = state.split("\n").last
indices = cols.split.map { |v| cols.index(v) }

objects = state.split("\n")[...-1]

STATE = cols.split.zip(indices.map { |idx|  objects.map { |line|   line[idx] }.filter { |v| v[0] != " " }}).to_h
CMDS = cmds.split("\n").map(&:split).map {|a| [a[1].to_i, a[3], a[5]] }

def step(cmd)
  (num, from, to) = cmd
  acc = STATE[from].take(num)
  STATE[from] = STATE[from].drop(num)
  STATE[to] = acc.reverse + STATE[to]
end

CMDS.each do |cmd|
  step(cmd)
end

puts STATE.values.map(&:first).join("")

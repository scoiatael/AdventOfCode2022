#!/usr/bin/env ruby
require 'set'

p File.read(ARGV.last).split.each_with_index.group_by { |v, idx| idx /3 }.values.map { |a| a.map(&:first).map { |v| v.split("") } }.map { |a,b,c| Set.new(a) & Set.new(b) & Set.new(c) }.map { |s| s.first.ord }.map { |v| if v > 'a'.ord then v+1-'a'.ord else 27+v-'A'.ord end }.reduce(:+)

#!/usr/bin/env ruby
require 'set'

p File.read(ARGV.last).split.map { |line| [line[0...line.size/2].split(""), line[line.size/2..-1].split("")] } .map { |(a, b)| Set.new(a) & Set.new(b) }.map { |s| s.first.ord }.map { |v| if v > 'a'.ord then v+1-'a'.ord else 27+v-'A'.ord end }.reduce(:+)

#!/usr/bin/env ruby
require 'set'

p File.read(ARGV.last).split.map { |l| l.split(",") }.map { |rs| rs.map { |r| r.split("-") }.map { |(a, b)| Set.new(Range.new(a, b)) }} .filter { |ra, rb| (ra & rb).size > 0  }.length

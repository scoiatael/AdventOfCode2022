#!/usr/bin/env ruby

require 'set'

File.read(ARGV.last).split.map { |line| p (line.size-4).times.filter { |idx| Set.new(line[idx...idx+4].split("")).size == 4 }.first + 4 }

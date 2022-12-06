#!/usr/bin/env ruby

require 'set'

File.read(ARGV.last).split.map { |line| p (line.size-14).times.filter { |idx| Set.new(line[idx...idx+14].split("")).size == 14 }.first + 14 }

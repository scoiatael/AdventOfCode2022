#!/usr/bin/env ruby
#
lines = File.read(ARGV.last).split("$")[1..-1]
DIRS = {}

def normalize(dir, ext)
  return [] if ext == "/"
  return dir[...-1] if ext == ".."
  return dir + ext.split("/")
end

def parse_ls(entries)
  entries.each_slice(2).map(&:first).map(&:to_i).select { |a| a > 0 }
end

dir = []
lines.each do |line|
  cmd, *args = line.split()
  dir = normalize(dir, args.last)  if cmd =~ /^cd/
  DIRS[dir] = (DIRS[dir] || []) + parse_ls(args) if cmd =~ /^ls/
end

def prefixes(arr)
  arr.size.times.collect { |i| arr[0...i] }
end

total_size_dirs = DIRS.map { |k, v| [k, v.reduce(:+)] }.to_h
DIRS.map do |k, v|
  prefixes(k).each { |pref| total_size_dirs[pref] = (total_size_dirs[pref] || 0) + (v.reduce(:+) || 0) }
end

have = 70000000 - total_size_dirs[[]]
needed = 30000000 - have
p total_size_dirs.values.select { |size| size > needed  }.sort.first

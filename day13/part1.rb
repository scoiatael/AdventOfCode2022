#!/usr/bin/env ruby

require 'yaml'

DATA = File.read(ARGV.last || "data/example.txt").split("\n\n").map { |pairs| pairs.split("\n").map { |pair| YAML.load(pair) } }

def compare(left, right)
  loop do
    case [left, right]
    in [Integer, Integer]
        return 1 if left < right
        return -1 if left > right
        return 0
    in [Array, Integer]
      right = [right]
    in [Integer, Array]
      left = [left]
    in [[], []]
        return 0
    in [[], _]
        return 1
    in [_, []]
        return -1
    in [Array, Array]
      leftHead, *leftTail = left
      rightHead, *rightTail = right
      case compare(leftHead, rightHead)
      in 0
        left = leftTail
        right = rightTail
      in v
        return v
      end
    end
  end
end

p DATA.each_with_index.map { |pair, idx| [idx+1, compare(*pair)] }.filter { |_, v| v == 1  }.map(&:first).reduce(:+)

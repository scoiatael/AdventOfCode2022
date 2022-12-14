#!/usr/bin/env ruby

INSTRUCTION_LENGTH = {
"noop" => 1,
"addx" => 2
}

DATA = File.read(ARGV.last).split("\n").map { |line| line.split } .map { |k| [k.first, k[1]&.to_i || 0] }

seqs = Enumerator.new do |y|
  reg = 1
  DATA.each do |elem|
    instr, change = elem
    INSTRUCTION_LENGTH[instr].times do
        y << reg
    end
    reg += change
  end
end

interesting =  seqs.each_with_index.map { |val, idx| [val, idx+1]}. select do |val, idx|
  (idx - 20) % 40 == 0
end

p interesting.map { |val, idx| [val * idx, val, idx] } .map(&:first).reduce(:+)

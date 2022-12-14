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

lines = seqs.each_with_index.each_slice(40)

def draw(line)
  line.map { |xreg, clock_cycle| if (xreg-1..xreg+1).include?(clock_cycle % 40) then '#' else '.' end  }.join("")
end

puts lines.map { |line| draw(line) }.join("\n")

p File.read(ARGV.last).split("\n\n").map { |gr| gr.split.map(&:to_i).reduce(:+) }.max

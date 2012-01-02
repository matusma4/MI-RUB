# USE THIS FILE TO RUN THE ALGORITHM AGAINST YOUT INPUT FILE, START, STOP
# takes command line arguments: inputFilePath fromPointNumber endPointNumber

require_relative '../lib/algorithm'

if(!ARGV[2])
  puts "wrong usage: expects 3 arguments: inputFile fromPoint endPoint"
  exit(1)
end

runner = Algorithm.new(ARGV)
runner.solve

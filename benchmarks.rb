require 'benchmark'
require_relative 'day_1'

Benchmark.bmbm do |x|
  x.report("recursion") { Day1.problem_2(0, 'day_1_input.txt')}
  x.report("loops") { Day1.problem_2_b(0, 'day_1_input.txt') }
end

# Rehearsal ---------------------------------------------
# recursion  50.180000   0.060000  50.240000 ( 50.280132)
# loops      51.850000   0.190000  52.040000 ( 52.166163)
# ---------------------------------- total: 102.280000sec

#                 user     system      total        real
# recursion  51.730000   0.170000  51.900000 ( 51.994835)
# loops      51.720000   0.190000  51.910000 ( 52.021825)
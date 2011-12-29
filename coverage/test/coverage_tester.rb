$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'coverage'

class Coverage_Tester < Test::Unit::TestCase
  def test_1
    solver = Coverage_Solver.new()
    segments = [Segment.new(-1, 0), Segment.new(-3, -5), Segment.new(2, 5)]
    assert_equal("0", solver.solve_coverage(0..1, segments))
  end
  def test_2
    solver = Coverage_Solver.new()
    segments = [Segment.new(-1, 0), Segment.new(0, 1)]
    assert_equal("1\n0 1", solver.solve_coverage(0..1, segments))
  end
  def test_3
    solver = Coverage_Solver.new()
    segments = [Segment.new(-2, 5), Segment.new(-1, 6), Segment.new(-1, 3), Segment.new(0, 4), Segment.new(1, 5), Segment.new(2, 6), Segment.new(3, 7), Segment.new(7, 8), Segment.new(8, 10), Segment.new(8, 9)]
    assert_equal("4\n0 4\n3 7\n7 8\n8 10", solver.solve_coverage(0..10, segments))
  end
  def test_4
    solver = Coverage_Solver.new()
    segments = [Segment.new(-2, 5), Segment.new(-1, 6), Segment.new(-1, 3), Segment.new(0, 4), Segment.new(1, 5), Segment.new(2, 6), Segment.new(3, 7), Segment.new(8, 10), Segment.new(8, 9)]
    assert_equal("0", solver.solve_coverage(0..10, segments))
  end
end

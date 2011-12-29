$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'ctverce'

class RectangleTest < Test::Unit::TestCase
  def test_1
    solver = Rectangles_Solver.new(Rectangle.new(4, 0, 0), Rectangle.new(2, 2, 2))
    assert_equal(19.0, solver.solve)
  end
  def test_2
    solver = Rectangles_Solver.new(Rectangle.new(4, 0, 0.000e-3), Rectangle.new(2.0e+0, -2, -2e0))
    assert_equal(19.0, solver.solve)
  end
  def test_3
    solver = Rectangles_Solver.new(Rectangle.new(5.23, -10e20, 3e-2), Rectangle.new(-1, 4.345643225, +3e100))
    assert_equal(false, solver.solve)
  end
  def test_4
    solver = Rectangles_Solver.new(Rectangle.new(5.23, -10e20, 3e-2), Rectangle.new(0.2, 4.345643225, +3e100))
    assert_equal(false, solver.solve)
  end
end

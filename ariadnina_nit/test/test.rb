$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'algorithm'

class AriadninaNitTest < Test::Unit::TestCase
  def test_1
    solver = Algorithm.new(["../input1", 1, 6])
    assert_equal("GO AND FIND IT\r\n1 -> 3, 3 -> 2, 2 -> 6, \r\nAND NOW GO BACK\r\n6 -> 2, 2 -> 3, 3 -> 1, ", solver.solve)
  end
  def test_2
    solver = Algorithm.new(["../input1", 3, 5])
    assert_equal("no path available", solver.solve)
  end
  def test_3
    solver = Algorithm.new(["../input2", 1, 10])
    assert_equal("GO AND FIND IT\r\n1 -> 3, 3 -> 5, 5 -> 1, 1 -> 6, 6 -> 4, 4 -> 7, 7 -> 1, 1 -> 8, 8 -> 4, 4 -> 9, 9 -> 1, 1 -> 9, 9 -> 2, 2 -> 9, 9 -> 4, 4 -> 10, \r\nAND NOW GO BACK\r\n10 -> 4, 4 -> 6, 6 -> 1, ", solver.solve)
  end
  def test_4
    solver = Algorithm.new(["../input2", 2, 11])
    assert_equal("no path available", solver.solve)
  end
end

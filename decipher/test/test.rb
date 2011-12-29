$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'decipher'

class DecipherTest < Test::Unit::TestCase
  def testit
    decipher = Decipher.new
    assert_equal("*CDC is the trademark of the Control Data Corporation.\003*IBM is a trademark of the International Business Machine Corporation.\003*DEC is the trademark of the Digital Equipment Corporation.",
      decipher.do_decipher("./decipher/input"))
  end
end
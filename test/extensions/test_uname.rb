#
# $Id$
#
require File.join(File.dirname(__FILE__), '..', 'test_helper.rb')

class TestUname < Test::Unit::TestCase

  def setup
    assert out = IO::popen('uname -n', 'r')
    assert out = out.readlines
    assert @node_should_be = out[0].chomp
  end

  def test_node
    assert node = Uname.node
    assert_equal @node_should_be, node
  end

end


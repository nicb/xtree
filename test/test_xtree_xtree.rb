#
# $Id$
#
require File.dirname(__FILE__) + '/test_helper.rb'

class TestXtreeXtree < Test::Unit::TestCase

	def setup
		assert @default_path = '.'
		assert @default_archive = Uname.node
	end

  def test_creation
		assert xt0 = Xtree::Xtree.new(@default_path, @default_archive)
		assert xt1 = Xtree::Xtree.new(@default_path)
		assert xt2 = Xtree::Xtree.new
		assert xt0 === xt1
		assert xt0 === xt2
		assert xt1 === xt2
  end

	def test_run
		assert xt = Xtree::Xtree.new
		assert output = xt.generate
	end

end

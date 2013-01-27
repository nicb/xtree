#
# $Id$
#
require File.join(File.dirname(__FILE__), '..', 'test_helper.rb')

require 'rexml/document'

class TestXtreeXtree < Test::Unit::TestCase

  XTREE_TEST_TREE_PATH = File.join(File.dirname(__FILE__), '..', 'fixtures', 'test_tree')

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

  def test_generation
    assert xt = Xtree::Xtree.new(XTREE_TEST_TREE_PATH, 'test archive')
    assert output = xt.generate
    assert resulting_tree = REXML::Document.new(output.to_s)
		assert_equal REXML::Document, resulting_tree.class
    resulting_tree.elements.each('archive') do
      |el|
      assert_equal Xtree::Archive, el.class
      el.elements.each do
        |elel|
        assert_equal Xtree::Entry, elel.class
      end
    end
  end

end

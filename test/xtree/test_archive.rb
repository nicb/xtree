#
# $Id$
#
require File.join(File.dirname(__FILE__), '..', 'test_helper.rb')

class TestXtreeArchive < Test::Unit::TestCase

	XTREE_TEST_TREE_PATH = File.join(File.dirname(__FILE__), '..', 'fixtures', 'test_tree')

  def test_creation
		assert a = Xtree::Archive.new('test_archive', XTREE_TEST_TREE_PATH)
		assert a.is_a?(REXML::Document)
		assert a.is_a?(REXML::Document), "Copied object is not a REXML::Document (class: #{a.class.name})"
		assert a.is_a?(Xtree::Archive), "Copied object is not a Xtre::Archive (class: #{a.class.name})"
		assert s = a.to_s
		assert a_copy = Xtree::Archive.new(s)
		assert a_copy.is_a?(REXML::Document), "Copied object is not a REXML::Document (class: #{a_copy.class.name})"
		assert a_copy.is_a?(Xtree::Archive), "Copied object is not a Xtree::Archive (class: #{a_copy.class.name})"
  end

	def test_content
		assert a = Xtree::Archive.new('test_archive', XTREE_TEST_TREE_PATH)
		assert a.is_a?(Xtree::Archive), "Copied object is not a Xtre::Archive (class: #{a.class.name})"
		assert a
	end

end

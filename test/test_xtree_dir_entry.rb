#
# $Id$
#
require File.dirname(__FILE__) + '/test_helper.rb'

class TestXtreeDirEntry < Test::Unit::TestCase

  TEST_TREE_PATH = File.join(File.dirname(__FILE__), 'fixtures', 'test_tree')

	def setup
		assert @test_tree = {
			'test_tree' => Xtree::Directory,
			'a_subdir' => Xtree::Directory,
			'nonzero_file' => Xtree::File,
			'zero_file' => Xtree::File,
			'hardlink_to_nonzero_file' => Xtree::File,
			'symlink_to_nonzero_file' => Xtree::SymLink,
	 }
	 assert @other_tests = {
			'/dev/tty' => Xtree::CharacterSpecial,
			'/dev/sda' => Xtree::BlockSpecial
		}
	end

  def test_parsing
		Dir.glob(File.join(TEST_TREE_PATH, '**')).each do
			|dir_entry|
			assert bde = File.basename(dir_entry)
			assert ftype = @test_tree[bde], "Directory entry: #{dir_entry}"
			assert xtde = Xtree::DirEntry.parse(dir_entry)
			assert_equal ftype, xtde.class, "File: #{dir_entry}"
		end
		@other_tests.each do
			|dentry, should_be|
			assert xtde = Xtree::DirEntry.parse(dentry)
			assert_equal should_be, xtde.class, "File: #{dentry}"
		end
  end

end

#
# $Id$
#
require File.join(File.dirname(__FILE__), '..', 'test_helper.rb')
require 'socket'

class TestXtreeEntry < Test::Unit::TestCase

	XTREE_TEST_TREE_PATH = File.join(File.dirname(__FILE__), '..', 'fixtures', 'test_tree')

  def setup
    assert @sock_name = 'a_socket'
    assert @full_sock_path = File.join(XTREE_TEST_TREE_PATH, @sock_name)
    assert UNIXServer.open(@full_sock_path) unless ::File.exists?(@full_sock_path)
    assert @test_tree = {
      'test_tree' => 'directory',
      'a_subdir' => 'directory',
      'nonzero_file' => 'file',
      'zero_file' => 'file',
      'hardlink_to_nonzero_file' => 'file',
      'symlink_to_nonzero_file' => 'link',
      @sock_name => 'socket',
   }
   assert @other_tests = {
      '/dev/tty' => 'characterSpecial',
      '/dev/sda' => 'blockSpecial',
    }
  end

  def teardown
    ::File.unlink(@full_sock_path)
  end

  def test_creation
    Dir.glob(File.join(XTREE_TEST_TREE_PATH, '**')).each do
      |dir_entry|
      assert bde = File.basename(dir_entry)
      assert ftype = @test_tree[bde], "Directory entry: #{dir_entry}"
      assert xtde = Xtree::Entry.new(dir_entry)
      assert_equal ftype, xtde.ftype, "File: #{dir_entry}"
    end
    @other_tests.each do
      |dentry, should_be|
      assert xtde = Xtree::Entry.new(dentry)
      assert_equal should_be, xtde.ftype, "File: #{dentry}"
    end
  end

  def test_proxies
    Dir.glob(File.join(XTREE_TEST_TREE_PATH, '**')).each do
      |dir_entry|
      assert bde = File.basename(dir_entry)
      assert ftype = @test_tree[bde], "Directory entry: #{dir_entry}"
      assert xtde = Xtree::Entry.new(dir_entry)
      Xtree::Entry::STAT_METHODS_TO_BE_PROXIED.each do
        |method|
        assert xtde.respond_to?(method.intern), "#{xtde.class}##{method}"
      end
      @other_tests.each do
        |dentry, should_be|
        Xtree::Entry::STAT_METHODS_TO_BE_PROXIED.each do
          |method|
          assert xtde.respond_to?(method.intern), "#{xtde.class}##{method}"
        end
      end
    end
  end

end

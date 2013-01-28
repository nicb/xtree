#
# $Id$
#
require File.join(File.dirname(__FILE__), '..', "test_helper.rb")
require 'xtree/cli'

class TestXtreeCli < Test::Unit::TestCase
  def setup
		assert @default_filename = 'xml_archive.xml'
		File.unlink(@default_filename) if File.exists?(@default_filename)
  end
  
	#
	# nothing happens here, so we must run the program and check that the output
	# is actually produced properly
	#
  def test_default_run
    assert Xtree::CLI.execute(@stdout_io = StringIO.new, [])
		#
		# no output should be emitted from stdout
		#
    assert_equal 0, @stdout_io.size
		assert File.exists?(@default_filename)
		assert File.unlink(@default_filename)
  end

  def test_minus_a_option
		assert archive_name = 'test_minus_a_archive'
		assert archive_filename = archive_name + '.xml'
    assert Xtree::CLI.execute(@stdout_io = StringIO.new, ['-a', archive_name ])
		#
		# no output should be emitted from stdout
		#
    assert_equal 0, @stdout_io.size
		assert File.exists?(archive_filename)
		assert File.unlink(archive_filename)
  end

  def test_different_path
    assert Xtree::CLI.execute(@stdout_io = StringIO.new, [ 'test/fixtures/test_tree' ])
		#
		# no output should be emitted from stdout
		#
    assert_equal 0, @stdout_io.size
		assert File.exists?(@default_filename)
		assert File.unlink(@default_filename)
  end

  def test_different_path_with_minus_a_option
		assert archive_name = 'test_minus_a_with_path_archive'
		assert archive_filename = archive_name + '.xml'
    assert Xtree::CLI.execute(@stdout_io = StringIO.new, [ '-a', archive_name, 'test/fixtures/test_tree' ])
		#
		# no output should be emitted from stdout
		#
    assert_equal 0, @stdout_io.size
		assert File.exists?(archive_filename)
		assert File.unlink(archive_filename)
  end

end

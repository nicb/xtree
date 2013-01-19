#
# $Id$
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Xtree
  VERSION = '0.0.1'
	XTREE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'xtree'))
end

%w(
		uname
		dir_entry
		xtree
).each { |f| require File.join(Xtree::XTREE_PATH, f) }

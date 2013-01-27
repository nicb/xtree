#
# $Id$
#
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Xtree
  VERSION = '0.0.1'
  XTREE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'xtree'))
  EXTENSIONS_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'extensions'))
end

%w(
	valid_xml
  string
	symbol
).each { |f| require File.join(Xtree::EXTENSIONS_PATH, f) }

%w(
  uname
  dir_entry
  xtree
).each { |f| require File.join(Xtree::XTREE_PATH, f) }

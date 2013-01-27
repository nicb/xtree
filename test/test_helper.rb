#
# $Id$
#
require 'rubygems'
begin
  require 'ruby-debug'
  ::Debugger.start
  ::Debugger.settings[:autoeval] = true if ::Debugger.respond_to?(:settings)
rescue LoadError
  # ruby-debug wasn't available so neither can the debugging be
  puts("could not load the debugger")
end

require 'stringio'
require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'xtree'))

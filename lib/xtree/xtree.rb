#
# $Id$
#

require 'rexml/document'

module Xtree

  class Xtree

    attr_reader :start_path, :archive, :tab

    def initialize(sp = '.', a = nil)
      @start_path = sp
      @archive = (a || Uname.node)
    end

    def ===(other)
      raise(RuntimeError, "Trying to test identity with a non-#{self.class.name} object") unless other.is_a?(self.class)
      (self.start_path == other.start_path) && (self.archive == other.archive)
    end

    class NotADirectory < RuntimeError; end

    def generate
			res = nil
      raise(NotADirectory, "[error opening dir #{self.start_path}]") unless ::File.directory?(self.start_path)
			root = Archive.new(self.archive, self.start_path)
			root.propagate_tree!
    end

  end

end

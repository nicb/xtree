#
# $Id$
#
module Xtree

  class Xtree

    attr_reader :start_path, :archive

    def initialize(sp = '.', a = nil)
      @start_path = sp
      @archive = (a || Uname.node)
      @tree = nil
    end

    def ===(other)
      raise(RuntimeError, "Trying to test identity with a non-#{self.class.name} object") unless other.is_a?(self.class)
      (self.start_path == other.start_path) && (self.archive == other.archive)
    end

    def generate
      @tree = self.class.recurse_from_here(self.start_path)
    end

  private

    class << self

      def recurse_from_here(dir)
				result = []
        Dir.chdir(dir) do
          Dir.glob('*').each do
            |filename|
              result = DirEntry.parse(filename)
              result = recurse_from_here(filename) if result.is_a?(Directory)
          end
        end
        result
      end

    end

  end

end

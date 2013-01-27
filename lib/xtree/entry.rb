#
# $Id$
#
require 'rexml/element'

module Xtree

  #
  # +Xtree::Entry+ is the core class
  #
  class Entry < REXML::Element

    attr_reader :filename, :stats

    def initialize(n)
      @filename = n
      @stats = ::File.lstat(self.filename)
			create_proxy_methods
			super(self.stats.ftype)
			self.add_namespace(XTREE_NAMESPACE)
			self.add_attribute('filename', self.filename)
			add_properties
			propagate_tree!
    end

		PROPERTIES = %w(
      atime mtime ctime blksize size blockdev? blocks chardev?
      dev dev_major dev_minor directory? executable? executable_real?
      file? ftype gid grpowned? mode nlink owned? pipe? rdev
      rdev_major rdev_minor readable? readable_real? setgid? setuid?
      socket? sticky? symlink? uid world_readable? world_writable?
      writable? writable_real? zero?
		)

    STAT_METHODS_TO_BE_PROXIED = [ '<=>', PROPERTIES ].flatten

  private

    def create_proxy_methods
      STAT_METHODS_TO_BE_PROXIED.each do
        |meth|
        meth_symbol = meth.intern
        self.class.send(:define_method, meth_symbol) { self.stats.send(meth_symbol) } unless self.respond_to?(meth_symbol)
      end
    end

		def add_properties
			PROPERTIES.each do
				|p|
				value = self.send(p)
				value = value ? 'yes' : 'no' if p =~ /\?\Z/
				self.add_attribute(p.to_valid_xml_attribute_name, value)
			end
		end

		#
		# <tt>propagate_tree!</tt> is the actual method that does all the children xml
		# generation work.
		#
		def propagate_tree!
			if self.ftype == 'directory'
				Dir.chdir(self.filename) do
					Dir.glob('*').each do
						|f|
						el = Entry.new(f)
						self.add_element(el)
					end
				end
			end
		end

  end

end

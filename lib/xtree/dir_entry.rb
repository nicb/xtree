#
# $Id$
#
module Xtree

	#
	# this is required to get the proper hierarchy, please see below for the
  # +Xtree::DirEntry+ class implementation
	#
	
	class DirEntry
	end

	class Directory < DirEntry
		public_class_method :new
	end

	class File < DirEntry
		public_class_method :new
	end

	class CharacterSpecial < DirEntry
		public_class_method :new
	end

	class BlockSpecial < DirEntry
		public_class_method :new
	end

	class Fifo < DirEntry
		public_class_method :new
	end

	class SymLink < DirEntry
		public_class_method :new
	end

	class Socket < DirEntry
		public_class_method :new
	end

	#
	# +Xtree::DirEntry+ is the base class
	#
	# it should not be created directly, the +parse+ method should be used
	# instead
	#
	class DirEntry

		attr_reader :filename, :stats

		private_class_method :new

		def initialize(n, s)
			@filename = n
			@stats = s
		end

		class << self

			#
			# +parse(filename)+ generates the appropriate Xtree::File class
			# (+Xtree::Directory+, +Xtree::File+, +Xtree::SymLink+, etc.) according
			# to the stats of the filename passed as argument
			#

			CLASSES = {
				'directory' => Xtree::Directory,
				'file'      => File,
				'characterSpecial' => CharacterSpecial,
				'blockSpecial' => BlockSpecial,
				'fifo' => Fifo,
				'socket' => Socket,
				'symlink' => SymLink,
			}

			def parse(filename)
				s = ::File.lstat(filename)
				t = s.symlink? ? 'symlink' : s.ftype
				related_class = CLASSES[t]
				related_class.new(filename, s)
			end

		end

	end

end

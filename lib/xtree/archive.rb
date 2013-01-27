#
# $Id$
#
require 'rexml/document'

module Xtree

	class Archive < REXML::Document

		attr_reader :created_at, :root_directory, :archive_name

    public_class_method :new

		#
		# <tt>Xtree::Archive.new(args*)</tt> creates a new archive.
		#
		# If the argument is *only* an @xml@ string, the string is passed directly
		# to the <tt>REXML::Document</tt> parent object (this is like cloning
		# via the @xml@ description).
		#
		# If there are two or three arguments then the object is created. The
		# arguments are taken to be:
		#
		# * the name of the archive
		# * the root directory
		# * the time of creation (optional - default: Time.now)
		#
		def initialize(*args)
			res = nil
			argc = args.size
			if argc == 1 && args.first.class == String
				super(args.first)
			elsif argc > 1
				(arcname, rdir, ca) = args
				ca = Time.now.to_s unless ca
				@archive_name = arcname
				@root_directory = rdir
				@created_at = ca
				super('archive')
				initialize_tree!
			else
				raise(ArgumentError, "Wrong arguments (#{args.inspect}) to #{self.class.name}")
			end
			self
		end

	private

		def initialize_tree!
			self << REXML::Document::DECLARATION
			self.add_namespace(XTREE_NAMESPACE)
			self.add_text(self.root_directory)
			self.add_attribute('created_at', self.created_at)
			tree = Entry.new(self.root_directory)
			self.add_element(tree)
			self
		end

	end

end

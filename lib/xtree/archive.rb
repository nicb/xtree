#
# $Id$
#
require 'rexml/element'

module Xtree

	class Archive < REXML::Element

		attr_reader :created_at, :root_directory, :archive_name

    public_class_method :new

		def initialize(n, r, ca = Time.now.to_s)
			@archive_name = n
			@root_directory = r
			@created_at = ca
			super('archive')
			initialize_tree!
			self.add_namespace(XTREE_NAMESPACE)
		end

		#
		# <tt>propagate_tree!</tt> is not done automatically for the +Archive+
		# class, to avoid unwanted side-effects. Thus, this method must be called
		# explicitely
		#
		def propagate_tree!
			doc = REXML::Document.new(self.archive_name)
			doc << REXML::Document::DECLARATION
			doc.add_element(self)
			doc
		end

	private

		def initialize_tree!
			self.add_attribute('name', self.archive_name)
			self.add_attribute('created_at', self.created_at)
			tree = Entry.new(self.root_directory)
			self.add_element(tree)
			self
		end

	end

end

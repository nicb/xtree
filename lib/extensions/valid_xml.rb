#
# $Id$
#

module Xtree

	#
	# The +ValidXml+ module is a mixin that provides (technically) String
	# methods to produce valid xml code for attributes and the like.
	#
	module ValidXml

		def to_valid_xml_attribute_name
			out = res = self.to_s.sub(/\A(.*)\?\Z/, 'is_\1').sub(/\A(.*)!\Z/,'must_\1').gsub(/\W+/, '_')
			out = res.intern if self.is_a?(Symbol)
		  out	
		end

	end

end

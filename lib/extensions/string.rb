#
# $Id$
#

#
# +String+ extensions:
#
class String

	def upcase?
	  context_check(self[0], 'A', 'Z')
	end

	def downcase?
	  context_check(self[0], 'a', 'z')
	end

	def underscore
		self.gsub(/([a-z0-9])([A-Z0-9])/, '\1_\2')
	end

	#
	# removes ruby module indications
	#
	def demodulize
		res = self
		pos = self.rindex(':')
		res = self[pos+1..self.size-1] if pos
		res
	end
	
	#
  # +to_xml_tag+ does basically the combination of
  # demodulize.underscore.downcase 
	#
	# It is needed in +Xtree+ to work out the tag names for each object
	#
	def to_xml_tag
		self.demodulize.underscore.downcase
	end

	#
	# what follows is the only thing that is needed to add +VakdXml+ methods to
  # the +String+ class
	#
	include Xtree::ValidXml

private

	def context_check(char, min, max)
		(char >= min && char <= max)
	end

end

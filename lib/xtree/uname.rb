#
# $Id$
#

require 'uname'

module Uname

		def self.node()
			self.invokeUname('-n')
		end

end

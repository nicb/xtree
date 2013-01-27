#
# $Id$
#
require File.dirname(__FILE__) + '/test_helper.rb'

class TestExtensionsSymbol < Test::Unit::TestCase

	def test_valid_xml_attribute_names
		assert tests = {
			:try_this? => :is_try_this,
			:now_try_this! => :must_now_try_this,
    }
		tests.each do
			|t, should_be|
			assert_equal should_be, t.to_valid_xml_attribute_name
		end
	end

end

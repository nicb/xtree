#
# $Id$
#
require File.join(File.dirname(__FILE__), '..', 'test_helper.rb')

class TestExtensionsString < Test::Unit::TestCase

	def test_upcase_query
		assert tests = {
			'Test::Test' => [true, false, false, false, false, false, true, false, false, false ],
			'a' => [false],
			'Z' => [true],
		}
	end

	def test_underscore
		assert tests = {
			'CamelString' => 'Camel_String',
			'Modulized::CamelString' => 'Modulized::Camel_String',
			'Several::Modules::String' => 'Several::Modules::String',
			'Several::Modules::CamelString' => 'Several::Modules::Camel_String',
			'SOMEthing::MORE::NotSoEasy' => 'SOMEthing::MORE::Not_So_Easy',
    }
		tests.each do
			|t, should_be|
			assert_equal should_be, t.underscore
		end
	end

	def test_demodulize
		assert tests = {
			'CamelString' => 'CamelString',
			'Modulized:CamelString' => 'CamelString',
			'Several:Modules:String' => 'String',
			'Several:Modules:CamelString' => 'CamelString',
			'SOMEthing:MORE:NotSoEasy' => 'NotSoEasy',
    }
		tests.each do
			|t, should_be|
			assert_equal should_be, t.demodulize
		end
	end

	def test_to_xml
		assert tests = {
			'CamelString' => 'camel_string',
			'Modulized:CamelString' => 'camel_string',
			'Several:Modules:String' => 'string',
			'Several:Modules:CamelString' => 'camel_string',
			'SOMEthing:MORE:NotSoEasy' => 'not_so_easy',
    }
		tests.each do
			|t, should_be|
			assert_equal should_be, t.to_xml_tag
		end
	end

	def test_to_valid_xml_attribute_name
		assert tests = {
			'CamelString?' => 'is_CamelString',
			'Modulized::CamelString?' => 'is_Modulized_CamelString',
			'Several::Modules::String!' => 'must_Several_Modules_String',
    }
		tests.each do
			|t, should_be|
			assert_equal should_be, t.to_valid_xml_attribute_name
		end
	end

end

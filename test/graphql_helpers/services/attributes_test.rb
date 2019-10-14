# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class AttributesTest < TestCase
      def test_snake_cases_attribute_keys
        args = { 'schoolBus' => { 'wheels' => 3 } }
        expected = { 'school_bus' => { 'wheels' => 3 } }

        attributes = Attributes.new.call(SchoolBus, args)
        assert_equal expected, attributes
      end

      def test_renames_nested_attributes
        args = { 'user' => { 'contacts' => [{ 'email' => 'test@test.com' }] } }
        expected = {
          'user' => {
            'contacts_attributes' => [{
              'email' => 'test@test.com'
            }]
          }
        }

        attributes = Attributes.new.call(User, args)
        assert_equal expected, attributes
      end
    end
  end
end

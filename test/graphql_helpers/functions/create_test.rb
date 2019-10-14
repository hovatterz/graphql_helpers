# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Functions
    class CreateTest < TestCase
      def test_responds_to_type_with_graphql_type
        assert_equal Types::ContactType, Create.new(Contact).type
      end

      def test_creates_record_for_given_model_type
        context = { current_user: User.find_by!(email: 'firstuser@test.com') }
        arguments = {
          'contact' => {
            'first_name' => 'New',
            'last_name' => 'Contact',
            'email': 'newcontact@test.com'
          }
        }
        Create.new(Contact).call(nil, arguments, context)

        assert_equal 'New', Contact.last.first_name
      end

      def test_creates_underscored_model_type
        arguments = {
          'schoolBus' => {
            'wheels' => 5
          }
        }
        Create.new(SchoolBus).call(nil, arguments, {})

        assert_equal 5, SchoolBus.last.wheels
      end
    end
  end
end

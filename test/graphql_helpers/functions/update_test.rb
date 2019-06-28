# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Functions
    class UpdateTest < Minitest::Test
      def test_responds_to_type_with_graphql_type
        assert_equal Types::ContactType, Update.new(Contact).type
      end

      def test_updates_record_for_given_model_type
        context = { current_user: User.find_by!(email: 'firstuser@test.com') }
        arguments = {
          'contact' => {
            'id' => Contact.first.id,
            'first_name' => 'Update Test'
          }
        }
        Update.new(Contact).call(nil, arguments, context)
        assert_equal 'Update Test', Contact.first.first_name
      end
    end
  end
end

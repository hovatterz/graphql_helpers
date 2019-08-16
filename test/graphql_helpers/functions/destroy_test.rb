# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Functions
    class DestroyTest < Minitest::Test
      def test_responds_to_type_with_graphql_type
        assert_equal Types::ContactType, Destroy.new(Contact).type
      end

      def test_destroys_record_for_given_model_type
        context = { current_user: User.find_by!(email: 'firstuser@test.com') }
        id = Contact.first.id
        arguments = { id: id }
        Destroy.new(Contact).call(nil, arguments, context)
        assert_nil Contact.find_by_id(id)
      end
    end
  end
end

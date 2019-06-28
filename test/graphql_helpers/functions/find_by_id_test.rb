# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Functions
    class FindByIdTest < Minitest::Test
      def test_responds_to_type_with_graphql_type
        assert_equal Types::ContactType, FindById.new(Contact).type
      end

      def test_finds_record_by_id
        context = { current_user: User.find_by!(email: 'adminuser@test.com') }
        args = { id: Contact.first.id }
        record = FindById.new(Contact).call(nil, args, context)
        assert_equal record, Contact.first
      end
    end
  end
end

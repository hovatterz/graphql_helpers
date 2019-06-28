# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Functions
    class FindAllTest < Minitest::Test
      def test_responds_to_type_with_graphql_type
        assert_equal Types::ContactType, FindAll.new(Contact).type.of_type
      end

      def test_it_finds_all_records
        context = { current_user: User.find_by!(email: 'adminuser@test.com') }
        args = {}
        records = FindAll.new(Contact).call(nil, args, context)

        assert_equal records, Contact.all
      end

      def test_it_finds_all_records_with_a_resolver
        contact = Contact.first
        context = { current_user: User.find_by!(email: 'adminuser@test.com') }
        args = {}
        records = FindAll.new(Contact, resolver: lambda { |obj, _args, _ctx|
          obj.where(id: contact.id)
        }).call(Contact.all, args, context)

        assert_equal 1, records.count
        assert_equal contact.id, records.first.id
      end
    end
  end
end

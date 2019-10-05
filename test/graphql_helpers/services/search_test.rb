# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class SearchTest < Minitest::Test
      def test_can_search_with_ransack
        args = {
          filters: {
            last_name_matches: 'Person%'
          }
        }
        contacts = Search.new.call(Contact.all, args)
        assert_equal Contact.where('last_name LIKE "Person%"').to_a, contacts.to_a

        args = {
          filters: {
            lastNameEq: 'Person2'
          }
        }
        contacts = Search.new.call(Contact.all, args)
        assert_equal Contact.where(last_name: 'Person2').to_a, contacts.to_a
      end
    end
  end
end

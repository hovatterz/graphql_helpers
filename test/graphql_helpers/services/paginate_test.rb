# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class PaginateTest < Minitest::Test
      def test_can_authorize_function_with_pundit
        args = {
          per_page: 1,
          page: 1
        }

        contacts = Paginate.new.call(Contact.all, args)
        assert_equal Contact.limit(1).offset(0).to_a, contacts.to_a
      end
    end
  end
end

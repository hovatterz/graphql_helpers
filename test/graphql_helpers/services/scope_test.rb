# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class ScopeTest < TestCase
      def test_can_scope_a_function_with_pundit
        current_user = User.find_by!(email: 'firstuser@test.com')
        context = { current_user: current_user }
        assert_equal current_user.contacts, Scope.new.call(context, Contact)
      end
    end
  end
end

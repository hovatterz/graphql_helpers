# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class AuthorizeTest < TestCase
      def test_can_authorize_function_with_pundit
        service = Authorize.new
        context = { current_user: User.find_by!(email: 'firstuser@test.com') }

        assert_raises Pundit::NotAuthorizedError do
          service.call(context, Contact.find_by!(email: 'testperson2@test.com'), :show?)
        end

        assert service.call(context, Contact.find_by!(email: 'testperson1@test.com'), :show?)
      end
    end
  end
end

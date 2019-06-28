# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class PermittedAttributesTest < Minitest::Test
      def test_can_provide_permitted_attributes_with_pundit
        context = { current_user: User.find_by!(email: 'firstuser@test.com') }
        test_args = {
          'first_name' => 'new first name',
          'last_name' => 'new last name',
          'email' => 'new email',
          'role' => 'admin',
          'contacts' => [{
            'first_name' => 'contact first name',
            'last_name' => 'contact last name',
            'email' => 'contact email'
          }]
        }

        params = PermittedAttributes.new.call(context, User, test_args)
        assert_nil params['role']
        assert_equal 'contact email', params[:contacts_attributes].first[:email]
      end
    end
  end
end

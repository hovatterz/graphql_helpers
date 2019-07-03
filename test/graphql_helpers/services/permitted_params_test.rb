# frozen_string_literal: true

require 'test_helper'

module GraphQLHelpers
  module Services
    class PermittedParamsTest < Minitest::Test
      def test_can_provide_permitted_attributes_with_pundit
        context = { current_user: User.find_by!(email: 'firstuser@test.com') }
        test_attributes = {
          'user' => {
            'first_name' => 'new first name',
            'last_name' => 'new last name',
            'email' => 'new email',
            'role' => 'admin',
            'contacts_attributes' => [{
              'first_name' => 'contact first name',
              'last_name' => 'contact last name',
              'email' => 'contact email'
            }]
          }
        }.with_indifferent_access

        params = PermittedParams.new.call(context, User, test_attributes)
        assert_nil params['role']
        assert_equal 'contact email', params[:contacts_attributes].first[:email]
      end
    end
  end
end

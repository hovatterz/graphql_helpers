# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a Pundit scope
    class Scope
      def call(ctx, scope)
        finder = Pundit::PolicyFinder.new(scope)
        finder.scope.new(ctx[:current_user], scope).resolve
      end
    end
  end
end

# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a limit and offset to a scope
    class Paginate
      def call(scope, args)
        scope = scope.limit(args[:per_page]) if args[:per_page].present?
        scope = scope.offset((args[:page] - 1) * args[:per_page]) if args[:page].present?
        scope
      end
    end
  end
end

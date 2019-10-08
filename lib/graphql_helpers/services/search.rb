# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a Ransack search
    class Search
      def call(scope, args, distinct = false)
        return scope if args[:filters].blank?

        filters = args[:filters]
        filters = filters.to_unsafe_h if filters.respond_to?(:to_unsafe_h)
        filters['s'] = filters['s'].underscore if filters['s'].present?

        query = scope.ransack(filters)
        query.result(distinct: distinct)
      end
    end
  end
end

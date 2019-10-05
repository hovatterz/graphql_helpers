# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a Ransack search
    class Search
      def call(relation, args, distinct = false)
        query = relation.ransack(args[:filters])
        query.result(distinct: distinct)
      end
    end
  end
end

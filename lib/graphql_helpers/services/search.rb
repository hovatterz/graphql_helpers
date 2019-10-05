# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a Ransack search
    class Search
      def call(relation, args, distinct = false)
        underscored = args[:filters].deep_transform_keys { |key| key.to_s.underscore }
        query = relation.ransack(underscored)
        query.result(distinct: distinct)
      end
    end
  end
end

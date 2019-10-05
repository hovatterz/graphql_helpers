# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a Ransack search
    class Search
      def call(relation, filters, distinct = false)
        filters = filters.to_unsafe_h if filters.respond_to?(:to_unsafe_h)
        underscored = filters
                      .deep_transform_keys { |k| k.to_s.underscore }
                      .with_indifferent_access
        underscored['s'] = underscored['s'].underscore if underscored['s'].present?

        query = relation.ransack(underscored)
        query.result(distinct: distinct)
      end
    end
  end
end

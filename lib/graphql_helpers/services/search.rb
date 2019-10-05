# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Applies a Ransack search
    class Search
      def call(relation, args, distinct = false)
        underscored = args[:filters].to_h.deep_transform_keys { |key| key.to_s.underscore }
        underscored['s'] = underscored['s'].underscore if underscored['s'].present?
        query = relation.ransack(underscored)
        query.result(distinct: distinct)
      end
    end
  end
end

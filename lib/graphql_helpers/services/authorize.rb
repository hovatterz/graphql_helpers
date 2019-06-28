# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Authorizes against a Pundit policy
    class Authorize
      def call(ctx, record, query)
        policy = Pundit::PolicyFinder.new(record).policy.new(ctx[:current_user], record)

        unless policy.public_send(query)
          raise(Pundit::NotAuthorizedError, query: query, record: record, policy: policy)
        end

        record
      end
    end
  end
end

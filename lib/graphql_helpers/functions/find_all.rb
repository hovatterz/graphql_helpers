# frozen_string_literal: true

module GraphQLHelpers
  module Functions
    # Finds all records of a model
    class FindAll < GraphQL::Function
      attr_reader :type

      argument :filters, GraphQL::Types::JSON

      def initialize(model, connection: false, resolver: nil)
        @model = model
        @resolver = resolver
        @type = if connection
                  Types.const_get("Types::#{model.name}Type").connection_type
                else
                  Types.const_get("Types::#{model.name}Type").to_list_type
                end
      end

      def call(obj, args, ctx)
        Services::Authorize.new.call(ctx, @model, :index?)
        resolver = @resolver.nil? ? @model : @resolver.call(obj, args, ctx)
        result = Services::Scope.new.call(ctx, resolver)
        return result unless args[:filters].present?

        Services::Search.new.call(result, args[:filters])
      end
    end
  end
end

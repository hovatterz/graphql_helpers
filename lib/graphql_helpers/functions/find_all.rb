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
        @type_const = Types.const_get("Types::#{model.name}Type")
        @type = if connection
                  build_connection_type
                else
                  @type_const.to_list_type
                end
      end

      def call(obj, args, ctx)
        Services::Authorize.new.call(ctx, @model, :index?)
        resolver = @resolver.nil? ? @model : @resolver.call(obj, args, ctx)
        result = Services::Scope.new.call(ctx, resolver)
        return result unless args[:filters].present?

        Services::Search.new.call(result, args[:filters])
      end

      private

      def build_connection_type
        connection_type = Class.new(GraphQL::Types::Relay::BaseConnection) do
          field :total_count, Integer, null: false

          def total_count
            object.nodes.size
          end
        end
        Object.const_set("#{@model.class.name}ConnectionWithTotalCount", connection_type)
        connection_type.send(:edge_type, @type_const.edge_type)
        connection_type
      end
    end
  end
end

# frozen_string_literal: true

module GraphQLHelpers
  module Functions
    # Finds all records of a model
    class FindAll < GraphQL::Function
      attr_reader :type

      argument :filters, GraphQL::Types::JSON, default_value: nil
      argument :page, GraphQL::Types::Int, default_value: nil
      argument :perPage, GraphQL::Types::Int, default_value: nil

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

      # rubocop:disable Metrics/AbcSize
      def call(obj, args, ctx)
        Services::Authorize.new.call(ctx, @model, :index?)
        resolver = @resolver.nil? ? @model : @resolver.call(obj, args, ctx)
        snaked = args.to_h.deep_transform_keys { |k| k.to_s.underscore }.with_indifferent_access
        result = Services::Scope.new.call(ctx, resolver)
        result = Services::Search.new.call(result, snaked)
        result = Services::Paginate.new.call(result, snaked)
        result
      end
      # rubocop:enable Metrics/AbcSize

      private

      def build_connection_type
        connection_type = Class.new(@type_const.connection_type) do
          field :total_count, Integer, null: false

          def total_count
            object.nodes.unscope(:limit, :offset).count
          end
        end

        Object.const_set("#{@model.name}ConnectionWithTotalCount", connection_type)
        connection_type.send(:edge_type, @type_const.edge_type)
        connection_type
      end
    end
  end
end

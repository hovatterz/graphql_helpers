# frozen_string_literal: true

module GraphQLHelpers
  module Functions
    # Finds a record by id
    class FindById < GraphQL::Function
      attr_reader :type

      def initialize(model)
        @model = model
        @type = Types.const_get("Types::#{model.name}Type")
      end

      description 'Retrieve resource by ID'

      argument :id, !types.ID, 'The ID of the resource to retrieve'

      def call(_obj, args, ctx)
        Services::Authorize.new.call(ctx, @model.find(args[:id]), :show?)
      end
    end
  end
end

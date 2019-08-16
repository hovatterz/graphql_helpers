# frozen_string_literal: true

module GraphQLHelpers
  module Functions
    # Destroys a record for a given model
    class Destroy < GraphQL::Function
      attr_reader :type

      def initialize(model)
        @model = model
        @type = Types.const_get("Types::#{model.name}Type")
        @param_key = model.model_name.param_key
      end

      argument :id, !types.ID, 'The ID of the resource to destroy'

      def call(_obj, args, ctx)
        record = Services::Authorize.new.call(ctx, @model.find(args[:id]), :destroy?)

        Services::Callbacks.new.call(@type, :destroy, ctx, record) do
          record.destroy!
        end

        record
      end
    end
  end
end

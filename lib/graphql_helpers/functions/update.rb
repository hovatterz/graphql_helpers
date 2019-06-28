# frozen_string_literal: true

module GraphQLHelpers
  module Functions
    # Updates a record
    class Update < GraphQL::Function
      attr_reader :type

      def initialize(model)
        @model = model
        @type = Types.const_get("Types::#{model.name}Type")
        @param_key = model.model_name.param_key
      end

      def call(_obj, args, ctx)
        params = args[@param_key].to_h.with_indifferent_access
        id = params.delete(@model.primary_key)

        record = Services::Authorize.new.call(ctx, @model.find(id), :update?)

        Services::Callbacks.new.call(@type, :update, ctx, record) do
          attributes = Services::PermittedAttributes.new.call(ctx, @model, params, :create)
          record.update!(attributes)
        end

        record
      end
    end
  end
end

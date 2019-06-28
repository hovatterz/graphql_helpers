# frozen_string_literal: true

module GraphQLHelpers
  module Functions
    # Creates a record for a given model
    class Create < GraphQL::Function
      attr_reader :type

      def initialize(model)
        @model = model
        @type = Types.const_get("Types::#{model.name}Type")
        @param_key = model.model_name.param_key
      end

      def call(_obj, args, ctx)
        params = args[@param_key].to_h.with_indifferent_access

        attributes = Services::PermittedAttributes.new.call(ctx, @model, params, :create)
        record = @model.new(attributes)

        Services::Callbacks.new.call(@type, :create, ctx, record) do
          Services::Authorize.new.call(ctx, record, :create?)
          record.save!
        end

        record
      end
    end
  end
end

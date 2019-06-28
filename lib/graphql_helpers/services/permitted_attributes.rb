# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Permits attributes from a Pundit policy and maps nested attributes
    class PermittedAttributes
      def call(ctx, model, args, action = nil)
        finder = Pundit::PolicyFinder.new(model)
        policy = finder.policy.new(ctx[:current_user], model)
        method_name = if policy.respond_to?("permitted_attributes_for_#{action}")
                        "permitted_attributes_for_#{action}"
                      else
                        'permitted_attributes'
                      end

        attributes = { "#{finder.param_key}": rename_nested_attributes(model, args) }
        params = ActionController::Parameters.new(attributes)
        params.require(finder.param_key).permit(*policy.public_send(method_name))
      end

      private

      def rename_nested_attributes(model, attributes)
        nested_attributes = {}
        nested_keys = attributes.keys & model.nested_attributes_options.keys.map(&:to_s)
        nested_keys.each do |nested_key|
          nested_attributes["#{nested_key}_attributes"] = attributes.delete(nested_key)
        end
        attributes.merge(nested_attributes)
      end
    end
  end
end

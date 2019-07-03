# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Permits attributes from a Pundit policy and maps nested attributes
    class PermittedParams
      def call(ctx, model, attributes, action = nil)
        finder = Pundit::PolicyFinder.new(model)
        policy = finder.policy.new(ctx[:current_user], model)
        method_name = if policy.respond_to?("permitted_attributes_for_#{action}")
                        "permitted_attributes_for_#{action}"
                      else
                        'permitted_attributes'
                      end

        params = ActionController::Parameters.new(attributes)
        params.require(finder.param_key).permit(*policy.public_send(method_name))
      end
    end
  end
end

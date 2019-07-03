# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Snake cases keys and converts nested attributes to the proper names for Rails
    class Attributes
      def call(model, args)
        attributes = transform_keys_underscore(args)
        param_key = model.model_name.param_key

        attributes[param_key] = rename_nested_attributes(model, attributes[param_key])
        attributes
      end

      private

      def transform_keys_underscore(args)
        args.to_h.deep_transform_keys { |k| k.to_s.underscore }.with_indifferent_access
      end

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

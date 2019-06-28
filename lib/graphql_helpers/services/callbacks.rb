# frozen_string_literal: true

module GraphQLHelpers
  module Services
    # Wraps a block with callback methods
    class Callbacks
      def call(type, method, ctx, record, &block)
        type.send("before_#{method}", ctx, record) if type.respond_to?("before_#{method}")
        block.call
        type.send("after_#{method}", ctx, record) if type.respond_to?("after_#{method}")
      end
    end
  end
end

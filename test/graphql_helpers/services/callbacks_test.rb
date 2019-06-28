# frozen_string_literal: true

require 'test_helper'

class MockType
  def self.before_create(_ctx, record)
    record.do_before_create
  end

  def self.after_create(_ctx, record)
    record.do_after_create
  end
end

module GraphQLHelpers
  module Services
    class CallbacksTest < Minitest::Test
      def test_calls_before_after_methods_arond_block
        context = {}
        record = Minitest::Mock.new
        record.expect(:do_before_create, true)
        record.expect(:do_after_create, true)

        Callbacks.new.call(MockType, :create, context, record) do
        end

        record.verify
      end
    end
  end
end

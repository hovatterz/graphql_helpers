# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'active_record'
require 'graphql_helpers'

require 'minitest/autorun'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

class TestCase < Minitest::Test
  def setup
    load File.join(File.dirname(__FILE__), 'support', 'seeds.rb')
  end
end

load File.join(File.dirname(__FILE__), 'support', 'schema.rb')
require File.join(File.dirname(__FILE__), 'support', 'models.rb')
require File.join(File.dirname(__FILE__), 'support', 'policies.rb')
require File.join(File.dirname(__FILE__), 'support', 'types.rb')

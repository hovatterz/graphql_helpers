# frozen_string_literal: true

require 'graphql'
require 'pundit'
require 'action_controller/metal/strong_parameters'

require 'graphql_helpers/version'
require 'graphql_helpers/services/attributes'
require 'graphql_helpers/services/authorize'
require 'graphql_helpers/services/permitted_params'
require 'graphql_helpers/services/scope'
require 'graphql_helpers/services/callbacks'
require 'graphql_helpers/functions/find_all'
require 'graphql_helpers/functions/find_by_id'
require 'graphql_helpers/functions/create'
require 'graphql_helpers/functions/update'

module GraphQLHelpers
  class Error < StandardError; end
end

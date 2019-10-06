# frozen_string_literal: true

module Types
  class ContactType < GraphQL::Schema::Object; end

  class UserType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false

    field :contacts, function: GraphQLHelpers::Functions::FindAll.new(
      Contact,
      resolver: ->(obj, _args, _ctx) { obj.contacts }
    )
  end

  class ContactType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :user_id, ID, null: false

    field :user, UserType, null: false

    def self.before_create(ctx, record)
      record.user = ctx[:current_user] unless record.user_id.present?
    end
  end

  class SchoolBusType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :wheels, Integer, null: false
  end

  class QueryType < GraphQL::Schema::Object
    field :contacts,
          function: GraphQLHelpers::Functions::FindAll.new(Contact, connection: true),
          connection: true,
          null: false
  end
end

class HelperSchema < GraphQL::Schema
  query(Types::QueryType)
end

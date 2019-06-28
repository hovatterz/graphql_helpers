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
end

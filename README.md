# GraphQLHelpers

GraphQLHelpers is a gem containing helpers for use with `graphql-ruby`.

It is currently designed to use with Pundit and Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql_helpers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphql_helpers

## Usage

In your query type you can define queries:

```ruby
module Types
  class QueryType < BaseObject
    field :user, function: GraphQLHelpers::Functions::FindById.new(User), null: true
    field :users, function: GraphQLHelpers::Functions::FindAll.new(User, connection: true), null: false
  end
end
```

In your mutation type you can define mutations:

```ruby
module Types
  class MutationType < Types::BaseObject
    field :update_user, function: GraphQLHelpers::Functions::Update.new(User) do
      argument :user, Types::UserInputType, required: true
    end
  end
end
```

Association fields can be defined:

```ruby
module Types
  class UserType < GraphQL::Schema::Object
    field :contacts, function: GraphQLHelpers::Functions::FindAll.new(
      Contact,
      resolver: ->(obj, _args, _ctx) { obj.contacts }
    )
  end
end
```

## Roadmap

- Implement filters/search/sort for the FindAll function

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hovatterz/graphql_helpers.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

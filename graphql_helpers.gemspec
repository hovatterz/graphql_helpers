# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'graphql_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'graphql_helpers'
  spec.version       = GraphQLHelpers::VERSION
  spec.authors       = ['Zack Hovatter']
  spec.email         = ['zackhovatter@gmail.com']

  spec.summary       = 'Helper library for working with graphql-ruby, pundit, and rails'
  spec.homepage      = 'https://github.com/hovatterz/graphql_helpers'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://rubygems.org'
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/hovatterz/graphql_helpers'
    spec.metadata['changelog_uri'] = 'https://github.com/hovatterz/graphql_helpers/changelog.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'guard', '~> 2.15.0'
  spec.add_development_dependency 'guard-minitest', '~> 2.4.6'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.72.0'
  spec.add_development_dependency 'sqlite3'

  spec.add_dependency 'graphql', '>= 1.9'
  spec.add_dependency 'pundit', '>= 2'
  spec.add_dependency 'rails', '>= 5'
  spec.add_dependency 'ransack', '>= 2.3'
end

# frozen_string_literal: true

guard 'minitest' do
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb$}) { 'test' }
  watch(%r{^test/.+_test\.rb$})
end

guard :rubocop, cli: %w[-D -S -a] do
  watch(/.rubocop.yml/)
  watch(/.+\.rb$/)
  watch(/Rakefile/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

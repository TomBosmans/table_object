# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in table_object.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
group :development, :test do
  # Testing framework
  gem 'minitest-spec-rails'
  # A library for setting up Ruby objects as test data
  gem 'factory_bot_rails'
  # Debugging tool
  gem 'pry'
end

group :development do
  # Annotate Rails classes with schema and routes info
  gem 'annotate'
end

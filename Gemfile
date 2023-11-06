# frozen_string_literal: true

source 'http://rubygems.org'

# Specify your gem's dependencies in bunnier.gemspec
gemspec

group :development, :test, :ci_test do
  gem 'simplecov', '~> 0.20'
  gem 'simplecov-cobertura', '~> 2.0'
end

group :test, :ci_test do
  gem 'rspec', '~> 3.0'
  gem 'rspec_junit_formatter', '~> 0.6.0'
  gem 'rubocop', '~> 1.20'
end

group :development do
  gem 'byebug', '~> 11.0'
  gem 'yard', '~> 0.9'
end

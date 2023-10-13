# frozen_string_literal: true

require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::CoberturaFormatter]
)

SimpleCov.start do
  add_filter('/spec/')
end

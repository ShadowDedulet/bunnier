# frozen_string_literal: true

module Bunnier
  # Utility methods
  # @since 0.1.0
  module Utils
    # Converts snake-case string to camel-case
    # @param term [String]
    # @return [String]
    # @example
    #		Bunnier::Utils.to_camel('someString_Here') #=> SomestringHere
    # @since 0.1.0
    def self.to_camel(term)
      term.split('_').map(&:capitalize).join
    end

    # Converts camel-case string to snake-case
    # @param term [String]
    # @return [String]
    # @example
    #		Bunnier::Utils.to_camel('SomeString_Here') #=> some_string_here
    # @since 0.1.0
    def self.to_snake(term)
      term.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
    end
  end
end

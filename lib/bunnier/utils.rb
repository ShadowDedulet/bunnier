# frozen_string_literal: true

module Bunnier
  module Utils
    def self.to_camel(term)
      term.split('_').map(&:capitalize).join
    end

    def self.to_snake(term)
      term.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
    end
  end
end

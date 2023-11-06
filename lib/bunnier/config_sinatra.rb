# frozen_string_literal: true

module Bunnier
  # Module for configurations using Sinatra
  # @note Use Bunnier::Config instead or include this module in your Config class
  # @abstract
  # @see Bunnier::ConfigDefault
  # @since 0.1.0
  # @todo implement defaults
  module ConfigSinatra
    include ConfigDefault
  end
end

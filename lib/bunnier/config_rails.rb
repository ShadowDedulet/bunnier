# frozen_string_literal: true

module Bunnier
  # Module for configurations using Rails
  # @note Use Bunnier::Config instead or include this module in your Config class
  # @abstract
  # @see Bunnier::ConfigDefault
  # @since 0.1.0
  module ConfigRails
    include ConfigDefault

    # @return [String] Rails engine_name
    # @see https://www.rubydoc.info/docs/rails/7.0.4.3/Rails/Engine Rails::Engine Documentation
    # @since 0.1.0
    def default_service_name
      ::Rails.application.engine_name
    end

    # @return [Class] Rails logger
    # @see https://www.rubydoc.info/docs/rails/7.0.4.3/Rails#logger-class_method Rails#logger Documentation
    # @since 0.1.0
    def default_logger
      ::Rails.logger
    end
  end
end

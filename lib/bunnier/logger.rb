# frozen_string_literal: true

module Bunnier
  # Gem`s logger
  # @note Class uses passed to it logger`s class and work`s like proxy
  # @attr [Class] base logger class to be used by Bunnier::Logger
  # @since 0.1.0
  class Logger
    include Errors

    attr_accessor :base

    # @param base_logger_class [Class] base logger class to be used by Bunnier::Logger
    # @example
    #		Bunnier::Logger.new(Rails.logger)
    # @since 0.1.0
    def initialize(base_logger_class)
      @base = base_logger_class
    end

    # Prints message safely (e.g. base logger errors)
    # @param args [Array]
    # @param kargs [Hash]
    # @since 0.1.0
    def safe_log(*args, **kargs)
      puts(*args, **kargs)
    end

    private

    # @private
    # @param method [String, Symbol] method name
    # @param args [Array]
    # @param kargs [Hash]
    # @raise [Bunnier::Errors::LogErrors::BadLevelError] if doesn`t respond to method
    def method_missing(method, *args, **kargs)
      raise(LogErrors::BadLevelError, method) unless respond_to?(method, *args, **kargs)

      base.send(method, *args, **kargs)
    end

    # @private
    # @param method [String, Symbol] method name
    # @param _args [Array]
    # @param _kargs [Hash]
    # @return [Bool] true if base logger respond to method
    # @since 0.1.0
    def respond_to_missing?(method, *_args, **_kargs)
      base.respond_to?(method)
    end
  end
end

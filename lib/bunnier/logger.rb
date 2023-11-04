# frozen_string_literal: true

module Bunnier
  class Logger
    include Errors

    attr_accessor :base

    def initialize(base_logger_class)
      @base = base_logger_class
    end

    def method_missing(method, *args, **kargs)
      raise(LogErrors::BadLevelError, method) unless respond_to?(method, *args, **kargs)

      base.send(method, *args, **kargs)
    end

    def respond_to_missing?(method, *_args, **_kargs)
      base.respond_to?(method)
    end

    def safe_log(*args, **kargs)
      puts(*args, **kargs)
    end
  end
end

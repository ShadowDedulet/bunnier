# frozen_string_literal: true

module Bunnier
  module Errors
    class BaseError < StandardError
      MESSAGE = nil
      HELPS = nil

      def initialize(message = nil, helps = nil)
        super(message || self.class::MESSAGE)

        helps ||= self.class::HELPS
        return unless helps

        Bunnier.logger.warn(helps)
      rescue LogError
        Bunnier.logger.safe_log(helps)
      end
    end

    module ConfigErrors
      class BaseError < BaseError
        MESSAGE = 'Configuration error'
      end

      class ConnectionError < BaseError
        MESSAGE = 'Connection url or options not set'
        HELPS = 'Use `Bunnier.config.connection = <conn_str_or_opts>` or set `BUNNIER_URL` ENV.'
      end

      class BadFrameworkError < BaseError
        MESSAGE = 'Framework `%s` not supported'
        HELPS = "Use `Bunnier.config.framework = <name>` or `Bunnier::Config.new(framework: <name>)\n" \
                "Supported frameworks options:\n" \
                "\t- :default\t(no framework)\n" \
                "\t- :rails\t(default if Rails defined)"

        def initialize(framework)
          super(format(MESSAGE, framework))
        end
      end
    end

    module LogErrors
      class BaseError < BaseError
        MESSAGE = 'Logger error'
      end

      class BadLevelError < BaseError
        MESSAGE = 'Logger `%s` doesn`t support `%s` level'
        HELPS = "Use `Bunnier.config.logger = <base_logger_class>` or `Bunnier::Logger.new(<base_logger_class>)\n" \
                "Out of the box loggers:\n" \
                "\t- Logger [ruby/logger]\t(default)\n" \
                "\t- Rails::Logger\t\t(default if Rails defined)"

        def initialize(level)
          super(format(MESSAGE, Bunnier.logger.base.class, level))
        end
      end
    end
  end
end

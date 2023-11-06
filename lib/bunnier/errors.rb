# frozen_string_literal: true

module Bunnier
  # Possible gem error classes
  # @since 0.1.0
  module Errors
    # Base gem error
    # @note Should be used only for rescuing or inheritance
    # @since 0.1.0
    class BaseError < StandardError
      # Default error message
      # @since 0.1.0
      MESSAGE = nil
      # Default error help text
      # @since 0.1.0
      HELPS = nil

      # @note calls Logger#warn to display help messages (calls Logger#sage_log if was error while logging)
      # @param message [String] error message
      # @param helps [String] error help text
      # @example without helps
      #		BaseError.new('My error') #=> #<BaseError: 'My error'>
      # @example with helps
      #		BaseError.new('My error', 'send help') #=> #<BaseError: 'My error'> and WARNING log 'send help'
      # @since 0.1.0
      def initialize(message = nil, helps = nil)
        super(message || self.class::MESSAGE)

        helps ||= self.class::HELPS
        return unless helps

        Bunnier.logger.warn(helps)
      rescue LogError
        Bunnier.logger.safe_log(helps)
      end
    end

    # Possible gem configuration error classes
    # @since 0.1.0
    module ConfigErrors
      # Base gem configuration error
      # @note Should be used only for rescuing or inheritance
      # @since 0.1.0
      class BaseError < BaseError
        MESSAGE = 'Configuration error'
      end

      # Empty connection params in config
      # @since 0.1.0
      class BadConnectionError < BaseError
        MESSAGE = 'Connection url or options not set'
        HELPS = 'Use `Bunnier.config.connection = <conn_str_or_opts>` or set `BUNNIER_URL` ENV.'
      end

      # Not-supported or misspeled framework in config
      # @since 0.1.0
      class BadFrameworkError < BaseError
        MESSAGE = 'Framework `%s` not supported'
        HELPS = "Use `Bunnier.config.framework = <name>` or `Bunnier::Config.new(framework: <name>)\n" \
                "Supported frameworks options:\n" \
                "\t- :default\t(no framework)\n" \
                "\t- :rails\t(default if Rails defined)"

        # @param framework [String | Symbol] framework name
        # @since 0.1.0
        def initialize(framework)
          super(format(MESSAGE, framework))
        end
      end
    end

    # Possible gem logging error classes
    # @since 0.1.0
    module LogErrors
      # Base gem logging error
      # @note Should be used only for rescuing or inheritance
      # @since 0.1.0
      class BaseError < BaseError
        MESSAGE = 'Logger error'
      end

      # Not-supported log level method called for logger
      # @since 0.1.0
      class BadLevelError < BaseError
        MESSAGE = 'Logger `%s` doesn`t support `%s` level'
        HELPS = "Use `Bunnier.config.logger = <base_logger_class>` or `Bunnier::Logger.new(<base_logger_class>)\n" \
                "Out of the box loggers:\n" \
                "\t- Logger [ruby/logger]\t(default)\n" \
                "\t- Rails::Logger\t\t(default if Rails defined)"

        # @param level [String | Symbol] log level
        # @since 0.1.0
        def initialize(level)
          super(format(MESSAGE, Bunnier.logger.base.class, level))
        end
      end
    end
  end
end

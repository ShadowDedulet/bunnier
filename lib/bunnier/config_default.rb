# frozen_string_literal: true

module Bunnier
  # Base module for configurations modules
  # @note Use Bunnier::Config instead or include this module in your Config class
  # @note Attributes may be set to any object
  # @abstract
  # @attr_writer [String, Hash] connection
  # @attr_writer [String] service_name
  # @attr_writer [String] hostname
  # @since 0.1.0
  module ConfigDefault
    include Errors

    # Environment keys
    # @since 0.1.0
    module ENVS
      BUNNIER_URL = 'BUNNIER_URL'
      SERVICE_NAME = 'SERVICE_NAME'
    end

    attr_writer :connection, :service_name, :hostname

    # Connection parameters
    # @return [String, Hash]
    # @raise [Bunnier::Errors::ConfigErrors::BadConnectionError] if not set or BUNNIER_URL env not set/empty
    # @example Connection is URL string
    #		Bunnier.config.connection #=> "amqp://guest:guest@rabbit.mq"
    # @see https://www.rubydoc.info/github/ruby-amqp/bunny/Bunny#new-class_method
    # @since 0.1.0
    def connection
      @connection ||= begin
        raise(ConfigErrors::BadConnectionError) if ENV[ENVS::BUNNIER_URL].nil? || ENV[ENVS::BUNNIER_URL].empty?

        ENV.fetch(ENVS::BUNNIER_URL, nil)
      end
    end

    # Service name
    # @return [String]
    # @example Running in vanilla ruby
    #   Bunnier.config.service_name #=> "app_script"
    # @since 0.1.0
    def service_name
      @service_name ||= ENV.fetch(ENVS::SERVICE_NAME, default_service_name)
    end

    # Host name
    # @return [String]
    # @example Running on machine "user-pc"
    #   Bunnier.config.hostname #=> "user-pc"
    # @since 0.1.0
    def hostname
      @hostname ||= Socket.gethostname
    end

    # Bunnier logger proxy
    # @return [Bunnier::Logger]
    # @since 0.1.0
    def logger
      self.logger = (default_logger) if @logger.nil?
      @logger
    end

    # Set passed logger class to be used by Bunnier::Logger
    # @return [Bunnier::Logger]
    # @example Use Rails logger
    #   Bunnier.config.logger = Rails.logger #=> Bunnier::Logger
    # @since 0.1.0
    def logger=(base_logger_class)
      @logger = Logger.new(base_logger_class)
    end

    # Default service name
    # @return [String] script filename
    # @since 0.1.0
    def default_service_name
      File.basename(File.dirname(__FILE__))
    end

    # Default logger class
    # @return [Class] RubyGem Logger class
    # @see https://rubydoc.info/gems/logger Logger Documentation
    # @since 0.1.0
    def default_logger
      ::Logger
    end
  end
end

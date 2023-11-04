# frozen_string_literal: true

module Bunnier
  module ConfigDefault
    include Errors

    module ENVS
      BUNNIER_URL = 'BUNNIER_URL'
      SERVICE_NAME = 'SERVICE_NAME'
    end

    attr_writer :connection, :service_name, :hostname

    def connection
      @connection ||= begin
        raise(ConfigErrors::ConnectionError) if ENV[ENVS::BUNNIER_URL].nil? || ENV[ENVS::BUNNIER_URL].empty?

        ENV.fetch(ENVS::BUNNIER_URL, nil)
      end
    end

    def service_name
      @service_name ||= ENV.fetch(ENVS::SERVICE_NAME, default_service_name)
    end

    def hostname
      @hostname ||= Socket.gethostname
    end

    def logger
      self.logger = (default_logger) if @logger.nil?
      @logger
    end

    def logger=(base_logger_class)
      @logger = Logger.new(base_logger_class)
    end

    private

    def default_service_name
      File.basename(File.dirname(__FILE__))
    end

    def default_logger
      ::Logger
    end
  end
end

# frozen_string_literal: true

require 'byebug'
require 'json'
require 'logger'
require 'securerandom'
require 'socket'

require_relative 'bunnier/version'
require_relative 'bunnier/utils'
require_relative 'bunnier/errors'
require_relative 'bunnier/logger'
require_relative 'bunnier/config_default'
require_relative 'bunnier/config'

# Client for RabbitMQ using Bunny
#   Gem`s entrypoint
# @note
# @abstract
# @since 0.1.0
module Bunnier
  # Configure gem
  # @yieldreturn [Bunnier::Config] defaulted config
  # @example
  #		Bunnier.configure do |config|
  #     config.service_name = 'App'
  #     config.connection = 'amqp://guest:guest@rabbit.mq'
  #   end
  # @see Bunnier::ConfigDefault
  # @since 0.1.0
  def self.configure
    yield(config)
  end

  # In-use config
  # @return [Bunnier::Config] defaulted config if not configured
  # @since 0.1.0
  def self.config
    @config ||= Config.new
  end

  # In-use logger
  # @return [Bunnier::Logger] defaulted logger if not configured
  # @see Bunnier::Config#logger=
  # @since 0.1.0
  def self.logger
    config.logger
  end
end

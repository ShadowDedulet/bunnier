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

module Bunnier
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end

  def self.logger
    config.logger
  end
end

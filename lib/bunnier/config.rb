# frozen_string_literal: true

module Bunnier
  # Gem configuration
  # @since 0.1.0
  class Config
    include ConfigDefault

    # @param framework [Symbol, String] framework name to load framework`s config
    # @return [Bunnier::Config]
    # @example
    #   Bunnier::Config.new(framework: :rails) #=> Bunnier::Config
    # @since 0.1.0
    def initialize(framework: nil)
      framework ||= :rails if defined?(::Rails)

      include_framework_config(framework.to_s.downcase) if framework
    end

    private

    # Includes framework`s config module to config
    # @private
    # @param framework_name [String]
    # @return [Bunnier::Config]
    # @raise [ConfigErrors::BadFrameworkError] if framework not supported or wrong name
    # @since 0.1.0
    def include_framework_config(framework_name)
      config_name = "config_#{framework_name}"
      require_relative config_name

      config_class_name = Bunnier::Utils.to_camel(config_name)

      config = Object.module_eval("Bunnier::#{config_class_name}", __FILE__, __LINE__) # Bunnier::Config<framework_name>
      self.class.include(config)
    rescue LoadError
      raise(ConfigErrors::BadFrameworkError, framework_name)
    end
  end
end

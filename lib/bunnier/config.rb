# frozen_string_literal: true

module Bunnier
  class Config
    include ConfigDefault

    def initialize(framework: nil)
      framework ||= :rails if defined?(::Rails)

      include_framework_config(framework.to_s.downcase) if framework
    end

    private

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

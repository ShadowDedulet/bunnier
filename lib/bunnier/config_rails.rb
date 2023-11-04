# frozen_string_literal: true

module Bunnier
  module ConfigRails
    include ConfigDefault

    def default_service_name
      ::Rails.application.engine_name
    end

    def default_logger
      ::Rails.logger
    end
  end
end

# frozen_string_literal: true

require "yaml"

module Tone
  module Configuration
    # Loads the default configuration into memory as a frozen hash.
    class Loader
      def initialize path: Pathname("#{__dir__}/defaults.yml")
        @path = path
      end

      def call = YAML.safe_load(path.read, symbolize_names: true).freeze

      private

      attr_reader :path
    end
  end
end

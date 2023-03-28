# frozen_string_literal: true

module Tone
  # The primary interface for working with colorized text.
  class Client
    def initialize enabled: $stdout.tty?, container: Tone::CONTAINER
      @aliaser = container.fetch(:aliaser).new defaults: container.fetch(:defaults)
      @encoder = container.fetch(:encoder).new(aliaser:, enabled:)
      @decoder = container.fetch(:decoder).new defaults: aliaser.defaults
    end

    def defaults = aliaser.defaults

    def aliases = aliaser.to_h

    def add_alias(...)
      aliaser.add(...)
      self
    end

    def get_alias(...) = aliaser.get(...)

    def encode(...) = encoder.call(...)

    alias [] encode

    def decode(...) = decoder.call(...)

    def find_code(key) = defaults[key]

    def find_codes(*keys) = defaults.values_at(*keys)

    def find_symbol(code) = defaults.invert[code]

    def find_symbols(*codes) = defaults.invert.values_at(*codes)

    private

    attr_reader :aliaser, :encoder, :decoder
  end
end

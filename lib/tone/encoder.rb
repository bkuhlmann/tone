# frozen_string_literal: true

require "refinements/array"

module Tone
  # Encodes plain text as colorized text.
  class Encoder
    using Refinements::Array

    def initialize aliaser: Aliaser.new, enabled: $stdout.tty?
      @aliaser = aliaser
      @enabled = enabled
    end

    def call(text, *styles)
      return "" if String(text).empty?

      !enabled || styles.tap(&:compact!).empty? ? text : "#{start(*styles)}#{text}#{stop}"
    end

    private

    attr_reader :aliaser, :enabled

    def start(*styles) = %(\e[#{escape(*styles)}m)

    def stop = "\e[#{defaults.fetch :clear}m"

    def escape(*styles)
      styles.reduce([]) { |expansion, key| expansion.append(*aliaser.get(key)) }
            .map { |key| defaults[key.to_sym] }
            .join ";"
    end

    def defaults = aliaser.defaults
  end
end

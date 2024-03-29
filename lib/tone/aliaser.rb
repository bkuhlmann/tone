# frozen_string_literal: true

require "refinements/array"

module Tone
  # Allows storage of custom custom which can be referenced when colorizing text.
  class Aliaser
    using Refinements::Array

    attr_reader :defaults

    def initialize defaults: DEFAULTS
      @defaults = defaults
      @custom = {}
    end

    def get key
      symbol = String(key).to_sym

      custom.fetch symbol do
        return key if defaults.key? symbol

        usage = defaults.keys.append(*custom.keys).to_usage "and/or"

        fail Error, "Invalid alias or default: #{key.inspect}. Use: #{usage}."
      end
    end

    def add(key, *styles)
      fail Error, "Alias must have styles: #{key.inspect}." if styles.tap(&:compact!).empty?

      custom[key.to_sym] = validate key, styles.map(&:to_sym)
      self
    end

    def to_h = custom.dup

    private

    attr_reader :custom

    def validate key, styles
      check_duplicate key
      styles.each { |style| check_style key, style }
      styles
    end

    def check_duplicate key
      fail Error, "Alias mustn't duplicate (override) default: #{key.inspect}." if defaults.key? key
    end

    def check_style key, style
      defaults.fetch style do
        usage = defaults.keys.to_usage "and/or"

        fail Error, "Invalid style (#{style.inspect}) for key (#{key.inspect}). Use: #{usage}."
      end
    end
  end
end

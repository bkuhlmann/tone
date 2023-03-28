# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.for_gem.setup

# Main namespace.
module Tone
  DEFAULTS = Configuration::Loader.new.call
  CONTAINER = {defaults: DEFAULTS, aliaser: Aliaser, encoder: Encoder, decoder: Decoder}.freeze
end

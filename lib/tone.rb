# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.for_gem.then do |loader|
  loader.ignore "#{__dir__}/rspec/matchers"
  loader.setup
end

# Main namespace.
module Tone
  DEFAULTS = Configuration::Loader.new.call
  CONTAINER = {defaults: DEFAULTS, aliaser: Aliaser, encoder: Encoder, decoder: Decoder}.freeze

  def self.new(...) = Client.new(...)
end

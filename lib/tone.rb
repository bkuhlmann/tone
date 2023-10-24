# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.new.then do |loader|
  loader.ignore "#{__dir__}/tone/rspec"
  loader.tag = File.basename __FILE__, ".rb"
  loader.push_dir __dir__
  loader.setup
end

# Main namespace.
module Tone
  DEFAULTS = Configuration::Loader.new.call
  CONTAINER = {defaults: DEFAULTS, aliaser: Aliaser, encoder: Encoder, decoder: Decoder}.freeze

  def self.loader(registry = Zeitwerk::Registry) = registry.loader_for __FILE__

  def self.new(...) = Client.new(...)
end

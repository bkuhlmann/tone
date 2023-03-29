# frozen_string_literal: true

require "strscan"

module Tone
  # Decodes color encoded text into metadata (hash).
  class Decoder
    PATTERN = /
      \e\[              # Start prefix.
      (?<codes>[\d;]+)  # Style codes.
      m                 # Start suffix.
      (?<text>.+?)      # Lazy text.
      \e\[0m            # Stop.
    /mx

    def initialize pattern: PATTERN, defaults: DEFAULTS, client: StringScanner
      @pattern = pattern
      @defaults = defaults
      @client = client
      @prefix_pattern = /.*#{pattern}/m
    end

    def call(text) = scan client.new(String(text))

    private

    attr_reader :pattern, :defaults, :client, :prefix_pattern

    def scan scanner, collection: []
      until scanner.eos?
        result = scanner.scan_until pattern

        return collection.append [scanner.string[scanner.rest]] unless result

        normal = scanner.pre_match.sub prefix_pattern, ""

        collection << [normal] unless normal.empty?
        collection << extract_captures(scanner)
      end

      collection
    end

    def extract_captures scanner
      codes, text = scanner.captures
      [text, *symbolize(codes)]
    end

    def symbolize(codes) = defaults.invert.values_at(*String(codes).split(";").map(&:to_i))
  end
end

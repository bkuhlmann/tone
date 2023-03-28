# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tone::Configuration::Loader do
  subject(:loader) { described_class.new }

  describe "#call" do
    include_context "with defaults"

    it "answers default hash" do
      expect(loader.call).to eq(defaults)
    end

    it "answers frozen hash" do
      expect(loader.call.frozen?).to be(true)
    end
  end
end

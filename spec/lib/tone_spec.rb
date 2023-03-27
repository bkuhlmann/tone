# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tone do
  describe ".new" do
    it "answers client" do
      expect(described_class.new).to be_a(Tone::Client)
    end
  end
end

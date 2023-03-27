# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tone::Aliaser do
  subject(:aliaser) { described_class.new }

  describe "#defaults" do
    it "answers defaults" do
      expect(aliaser.defaults).to eq(Tone::DEFAULTS)
    end
  end

  describe "#get" do
    before { aliaser.add :success, :black, :on_green }

    it "answers styles for alias (symbol)" do
      expect(aliaser.get(:success)).to eq(%i[black on_green])
    end

    it "answers styles for alias (string)" do
      expect(aliaser.get("success")).to eq(%i[black on_green])
    end

    it "answers original key (symbol) when alias can't be found but default exists" do
      expect(aliaser.get(:green)).to eq(:green)
    end

    it "answers original key (string) when alias can't be found but default exists" do
      expect(aliaser.get("green")).to eq("green")
    end

    it "fails when given nil" do
      expectation = proc { aliaser.get nil }

      expect(&expectation).to raise_error(
        Tone::Error,
        /Invalid alias or default: nil. Use: :clear.+/
      )
    end

    it "fails when alias or default can't be found" do
      expectation = proc { aliaser.get :bogus }

      expect(&expectation).to raise_error(
        Tone::Error,
        /Invalid alias or default: :bogus. Use: :clear.+/
      )
    end

    it "fails with defaults and aliases listed when not found" do
      aliaser = described_class.new(defaults: {clear: 0}).add :reset, :clear
      expectation = proc { aliaser.get :bogus }

      expect(&expectation).to raise_error(
        Tone::Error,
        %r(Invalid alias or default: :bogus. Use: :clear and/or :reset.)
      )
    end
  end

  describe "#add" do
    it "adds styles (symbols) for alias (symbol)" do
      aliaser.add :success, :black, :on_green
      expect(aliaser.to_h).to eq(success: %i[black on_green])
    end

    it "adds styles (strings) for alias (string)" do
      aliaser.add "success", "black", "on_green"
      expect(aliaser.to_h).to eq(success: %i[black on_green])
    end

    it "answers itself" do
      expect(aliaser.add(:reset, :clear)).to be_a(described_class)
    end

    it "only adds valid style intermixed with nils" do
      aliaser.add :success, nil, :green, nil
      expect(aliaser.to_h).to eq(success: [:green])
    end

    it "fails with alias only" do
      expectation = proc { aliaser.add :test }
      expect(&expectation).to raise_error(Tone::Error, /Alias must have styles: :test./)
    end

    it "fails with nil styles" do
      expectation = proc { aliaser.add :test, nil }
      expect(&expectation).to raise_error(Tone::Error, /Alias must have styles: :test./)
    end

    it "fails when duplicate alias exists" do
      aliaser.add :reset, :clear
      expectation = proc { aliaser.add :reset, :color }

      expect(&expectation).to raise_error(
        Tone::Error,
        /Duplicate alias detected \(already exists\): :reset./
      )
    end

    it "fails when duplicating a default" do
      expectation = proc { aliaser.add :red, :bogus }

      expect(&expectation).to raise_error(
        Tone::Error,
        /Alias mustn't duplicate \(override\) default: :red./
      )
    end

    it "fails when style doesn't exist" do
      expectation = proc { aliaser.add :test, :bogus }

      expect(&expectation).to raise_error(
        Tone::Error,
        /Invalid style \(:bogus\) for key \(:test\)\. Use: :clear.+/
      )
    end
  end

  describe "#to_h" do
    before { aliaser.add(:success, :black, :on_green).add :failure, :white, :on_red }

    it "answers hash of custom styles" do
      expect(aliaser.to_h).to eq(success: %i[black on_green], failure: %i[white on_red])
    end

    it "answers duplicate of original hash" do
      mutation = aliaser.to_h
      mutation[:extra] = "test"

      expect(aliaser.to_h).not_to eq(mutation)
    end
  end
end

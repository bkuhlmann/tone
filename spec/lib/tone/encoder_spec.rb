# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tone::Encoder do
  subject(:encoder) { described_class.new }

  describe "#call" do
    it "answers clear text" do
      expect(encoder.call("test", :clear)).to eq("\e[0mtest\e[0m")
    end

    it "answers bold text" do
      expect(encoder.call("test", :bold)).to eq("\e[1mtest\e[0m")
    end

    it "answers dim text" do
      expect(encoder.call("test", :dim)).to eq("\e[2mtest\e[0m")
    end

    it "answers italic text" do
      expect(encoder.call("test", :italic)).to eq("\e[3mtest\e[0m")
    end

    it "answers underlined text" do
      expect(encoder.call("test", :underline)).to eq("\e[4mtest\e[0m")
    end

    it "answers inverse text" do
      expect(encoder.call("test", :inverse)).to eq("\e[7mtest\e[0m")
    end

    it "answers hidden text" do
      expect(encoder.call("test", :hidden)).to eq("\e[8mtest\e[0m")
    end

    it "answers strikethrough text" do
      expect(encoder.call("test", :strikethrough)).to eq("\e[9mtest\e[0m")
    end

    it "answers text with black foreground color" do
      expect(encoder.call("test", :black)).to eq("\e[30mtest\e[0m")
    end

    it "answers text with red foreground color" do
      expect(encoder.call("test", :red)).to eq("\e[31mtest\e[0m")
    end

    it "answers text with green foreground color" do
      expect(encoder.call("test", :green)).to eq("\e[32mtest\e[0m")
    end

    it "answers text with yellow foreground color" do
      expect(encoder.call("test", :yellow)).to eq("\e[33mtest\e[0m")
    end

    it "answers text with blue foreground color" do
      expect(encoder.call("test", :blue)).to eq("\e[34mtest\e[0m")
    end

    it "answers text with purple foreground color" do
      expect(encoder.call("test", :purple)).to eq("\e[35mtest\e[0m")
    end

    it "answers text with cyan foreground color" do
      expect(encoder.call("test", :cyan)).to eq("\e[36mtest\e[0m")
    end

    it "answers text with white foreground color" do
      expect(encoder.call("test", :white)).to eq("\e[37mtest\e[0m")
    end

    it "answers text with bright black foreground color" do
      expect(encoder.call("test", :bright_black)).to eq("\e[90mtest\e[0m")
    end

    it "answers text with bright red foreground color" do
      expect(encoder.call("test", :bright_red)).to eq("\e[91mtest\e[0m")
    end

    it "answers text with bright green foreground color" do
      expect(encoder.call("test", :bright_green)).to eq("\e[92mtest\e[0m")
    end

    it "answers text with bright yellow foreground color" do
      expect(encoder.call("test", :bright_yellow)).to eq("\e[93mtest\e[0m")
    end

    it "answers text with bright blue foreground color" do
      expect(encoder.call("test", :bright_blue)).to eq("\e[94mtest\e[0m")
    end

    it "answers text with bright purple foreground color" do
      expect(encoder.call("test", :bright_purple)).to eq("\e[95mtest\e[0m")
    end

    it "answers text with bright cyan foreground color" do
      expect(encoder.call("test", :bright_cyan)).to eq("\e[96mtest\e[0m")
    end

    it "answers text with bright white foreground color" do
      expect(encoder.call("test", :bright_white)).to eq("\e[97mtest\e[0m")
    end

    it "answers text with black background color" do
      expect(encoder.call("test", :on_black)).to eq("\e[40mtest\e[0m")
    end

    it "answers text with red background color" do
      expect(encoder.call("test", :on_red)).to eq("\e[41mtest\e[0m")
    end

    it "answers text with green background color" do
      expect(encoder.call("test", :on_green)).to eq("\e[42mtest\e[0m")
    end

    it "answers text with yellow background color" do
      expect(encoder.call("test", :on_yellow)).to eq("\e[43mtest\e[0m")
    end

    it "answers text with blue background color" do
      expect(encoder.call("test", :on_blue)).to eq("\e[44mtest\e[0m")
    end

    it "answers text with purple background color" do
      expect(encoder.call("test", :on_purple)).to eq("\e[45mtest\e[0m")
    end

    it "answers text with cyan background color" do
      expect(encoder.call("test", :on_cyan)).to eq("\e[46mtest\e[0m")
    end

    it "answers text with white background color" do
      expect(encoder.call("test", :on_white)).to eq("\e[47mtest\e[0m")
    end

    it "answers text with bright black background color" do
      expect(encoder.call("test", :on_bright_black)).to eq("\e[100mtest\e[0m")
    end

    it "answers text with bright red background color" do
      expect(encoder.call("test", :on_bright_red)).to eq("\e[101mtest\e[0m")
    end

    it "answers text with bright green background color" do
      expect(encoder.call("test", :on_bright_green)).to eq("\e[102mtest\e[0m")
    end

    it "answers text with bright yellow background color" do
      expect(encoder.call("test", :on_bright_yellow)).to eq("\e[103mtest\e[0m")
    end

    it "answers text with bright blue background color" do
      expect(encoder.call("test", :on_bright_blue)).to eq("\e[104mtest\e[0m")
    end

    it "answers text with bright purple background color" do
      expect(encoder.call("test", :on_bright_purple)).to eq("\e[105mtest\e[0m")
    end

    it "answers text with bright cyan background color" do
      expect(encoder.call("test", :on_bright_cyan)).to eq("\e[106mtest\e[0m")
    end

    it "answers text with bright white background color" do
      expect(encoder.call("test", :on_bright_white)).to eq("\e[107mtest\e[0m")
    end

    it "answers colorized text with combination of styles" do
      expect(encoder.call("test", :red, :on_white, :bold)).to eq("\e[31;47;1mtest\e[0m")
    end

    it "answers colorized text for string styles" do
      expect(encoder.call("test", "black", "on_yellow")).to eq("\e[30;43mtest\e[0m")
    end

    it "answers colorized text for mix of valid an nil styles" do
      expect(encoder.call("test", :red, nil, :on_white)).to eq("\e[31;47mtest\e[0m")
    end

    it "answers colorized text for alias" do
      aliaser = Tone::Aliaser.new.add :success, :black, :on_green
      encoder = described_class.new(aliaser:)

      expect(encoder.call("test", :success)).to eq("\e[30;42mtest\e[0m")
    end

    it "answers empty string when text is nil" do
      expect(encoder.call(nil, :red)).to eq("")
    end

    it "answers empty string when text is empty" do
      expect(encoder.call("", :red)).to eq("")
    end

    it "answers original text when disabled" do
      encoder = described_class.new enabled: false
      expect(encoder.call("test", :red)).to eq("test")
    end

    it "answers original text when no styles are provided" do
      expect(encoder.call("test")).to eq("test")
    end

    it "answers original text when style is nil" do
      expect(encoder.call("test", nil)).to eq("test")
    end

    it "fails with invalid key" do
      expectation = proc { encoder.call "test", :bogus }

      expect(&expectation).to raise_error(
        Tone::Error,
        /Invalid alias or default: :bogus. Use: :clear.+/
      )
    end
  end
end

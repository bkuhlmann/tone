# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tone::Decoder do
  subject(:decoder) { described_class.new }

  describe "#call" do
    it "answers array for plain text" do
      expect(decoder.call("test")).to contain_exactly(["test"])
    end

    it "answers array for encoded text" do
      expect(decoder.call("\e[32mtest\e[0m")).to contain_exactly(["test", :green])
    end

    it "answers array for encoded phrase" do
      expect(decoder.call("\e[32mthis is a test\e[0m")).to contain_exactly(
        ["this is a test", :green]
      )
    end

    it "answers array for encoded lines" do
      expect(decoder.call("\e[32mOne.\nTwo.\nThree.\e[0m")).to contain_exactly(
        ["One.\nTwo.\nThree.", :green]
      )
    end

    it "answers array for encoded text separated by a single space" do
      expect(decoder.call("\e[32mtest\e[0m \e[32mtest\e[0m")).to eq(
        [
          ["test", :green],
          [" "],
          ["test", :green]
        ]
      )
    end

    it "answers array for encoded text with no separation" do
      expect(decoder.call("\e[32mtest\e[0m\e[32mtest\e[0m")).to eq(
        [
          ["test", :green],
          ["test", :green]
        ]
      )
    end

    it "answers array for encoded text interspesed with plain text" do
      result = decoder.call "\e[32mA\e[0ma\e[32mB\e[0mb\e[32mC\e[0mc\e[32mD\e[0m"

      expect(result).to contain_exactly(
        ["A", :green],
        ["a"],
        ["B", :green],
        ["b"],
        ["C", :green],
        ["c"],
        ["D", :green]
      )
    end

    it "answers array for encoded text with multiple styles" do
      expect(decoder.call("\e[32;40;2mtest\e[0m")).to contain_exactly(
        ["test", :green, :on_black, :dim]
      )
    end

    it "answers array for encoded text within paragraphs" do
      text = <<~CONTENT
        One
        \e[32mtest\e[0m
        Two
        \e[32mtest\e[0m
        Three
      CONTENT

      expect(decoder.call(text)).to eq(
        [
          ["One\n"],
          ["test", :green],
          ["\nTwo\n"],
          ["test", :green],
          ["\nThree\n"]
        ]
      )
    end

    it "answers array for encoded text within multiple lines" do
      text = "This is a \e[32;40;2mtest\e[0m\n and another \e[32mtest\e[0m"
      expect(decoder.call(text)).to eq(
        [
          ["This is a "],
          ["test", :green, :on_black, :dim],
          ["\n and another "],
          ["test", :green]
        ]
      )
    end

    it "answers empty array with empty text" do
      expect(decoder.call("")).to eq([])
    end

    it "answers empty array with nil text" do
      expect(decoder.call(nil)).to eq([])
    end
  end
end

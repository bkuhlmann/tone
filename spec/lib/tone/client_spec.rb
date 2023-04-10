# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tone::Client do
  subject(:client) { described_class.new }

  describe "#defaults" do
    include_context "with defaults"

    it "answers defaults" do
      expect(client.defaults).to eq(defaults)
    end
  end

  describe "#aliases" do
    it "answers default aliases" do
      expect(client.aliases).to eq({})
    end

    it "answers custom aliases" do
      client.add_alias :success, :black, :on_green
      expect(client.aliases).to eq(success: %i[black on_green])
    end
  end

  describe "#add_alias" do
    it "answers colorized text for alias" do
      client.add_alias :success, :black, :on_green
      expect(client.encode("test", :success)).to eq("\e[30;42mtest\e[0m")
    end

    it "answers itself" do
      expect(client.add_alias(:reset, :clear)).to be_a(described_class)
    end
  end

  describe "#get_alias" do
    it "answers styles for given alias" do
      client.add_alias :success, :black, :on_green
      expect(client.get_alias(:success)).to eq(%i[black on_green])
    end
  end

  describe "#[]" do
    it "answers colored text" do
      expect(client["test", :green]).to eq("\e[32mtest\e[0m")
    end
  end

  describe "#encode" do
    it "answers colored text" do
      expect(client.encode("test", :green)).to eq("\e[32mtest\e[0m")
    end
  end

  describe "#decode" do
    it "decodes text as tuples of text and color" do
      expect(client.decode("This is a \e[32mtest\e[0m.")).to contain_exactly(
        ["This is a "],
        ["test", :green],
        ["."]
      )
    end
  end

  describe "#find_code" do
    it "answers code for key" do
      expect(client.find_code(:green)).to eq(32)
    end

    it "answers nil for invalid key" do
      expect(client.find_code(:bogus)).to be(nil)
    end
  end

  describe "#find_codes" do
    it "answers array with single code for key" do
      expect(client.find_codes(:green)).to contain_exactly(32)
    end

    it "answers array of codes for keys" do
      expect(client.find_codes(:red, :green, :blue)).to contain_exactly(31, 32, 34)
    end

    it "answers array of nils for invalid keys" do
      expect(client.find_codes(:bogus, :bogus, :bogus)).to contain_exactly(nil, nil, nil)
    end
  end

  describe "#find_symbol" do
    it "answers symbol for code" do
      expect(client.find_symbol(32)).to eq(:green)
    end

    it "answers nil for invalid code" do
      expect(client.find_symbol(666)).to be(nil)
    end
  end

  describe "#find_symbols" do
    it "answers array with single symbol for code" do
      expect(client.find_symbols(32)).to contain_exactly(:green)
    end

    it "answers array of symbols for codes" do
      expect(client.find_symbols(31, 32, 34)).to contain_exactly(:red, :green, :blue)
    end

    it "answers array of nils for invalid keys" do
      expect(client.find_symbols(666, 666, 666)).to contain_exactly(nil, nil, nil)
    end
  end

  describe "#inspect" do
    it "answers simpliied information about encoder, decoder, and aliaser" do
      expect(client.inspect).to match(
        /
          #<Tone::Client.+@encoder=#<Tone::Encoder.+@decoder=#<Tone::Decoder.+
          @aliaser=#<Tone::Aliaser.+>
        /x
      )
    end
  end
end

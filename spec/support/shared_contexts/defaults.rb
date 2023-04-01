# frozen_string_literal: true

require "yaml"

RSpec.shared_context "with defaults" do
  let :defaults do
    YAML.safe_load_file Bundler.root.join("lib/tone/configuration/defaults.yml"),
                        symbolize_names: true
  end
end

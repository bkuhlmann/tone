# frozen_string_literal: true

require "yaml"

RSpec.shared_context "with defaults" do
  let :defaults do
    YAML.safe_load Bundler.root.join("lib/tone/configuration/defaults.yml").read,
                   symbolize_names: true
  end
end

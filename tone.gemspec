# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "tone"
  spec.version = "2.3.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/tone"
  spec.summary = "A customizable ANSI text terminal colorizer."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/tone/issues",
    "changelog_uri" => "https://alchemists.io/projects/tone/versions",
    "homepage_uri" => "https://alchemists.io/projects/tone",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Tone",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/tone"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "refinements", "~> 13.3"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end

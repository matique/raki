# frozen_string_literal: true

require_relative "lib/raki/version"

Gem::Specification.new do |s|
  s.name = "raki"
  s.version = Raki::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "Kind of chaining objects"
  s.license = "MIT"

  s.description = <<~EOF
    Raki enables chaining of objects.
    It is based on the definition of an interface and
    some builders.

    Chained Rakis must conforms to the Raki definition.
  EOF

  s.metadata["source_code_uri"] = "https://github.com/matique/raki"

  s.files = Dir.glob("lib/**/*") + %w[README.md LICENSE]

  s.require_path = "lib"

  s.author = "Dittmar Krall"
  s.email = "dittmar.krall@matiq.com"
  s.homepage = "https://matiq.com"

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-global_expectations"
end

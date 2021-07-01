# frozen_string_literal: true

require_relative "lib/raki/version"

Gem::Specification.new do |s|
  s.name = "raki"
  s.version = Raki::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "A modular hash interface."
  s.license = "MIT"

  s.description = <<~EOF
    Raki is under construction
  EOF

  s.files = Dir.glob("lib/**/*") + %w[README.md LICENSE]

  s.require_path = "lib"

  s.author = "Dittmar Krall"
  s.email = "dittmar.krall@matique.de"
  s.homepage = "https://matique.com"

  #  s.required_ruby_version = '>= 2.6'

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-global_expectations"
end

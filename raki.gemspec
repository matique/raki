# frozen_string_literal: true

require_relative 'lib/raki/version'

Gem::Specification.new do |s|
  s.name = "raki"
  s.version = Raki::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "A modular hash interface."
  s.license = "MIT"

  s.description = <<~EOF
    Raki provides a minimal, modular and adaptable interface for developing
    web applications in Ruby. By wrapping HTTP requests and responses in
    the simplest way possible, it unifies and distills the API for web
    servers, web frameworks, and software in between (the so-called
    middleware) into a single method call.
  EOF

  s.files = Dir['{bin/*,contrib/*,example/*,lib/**/*}'] +
    %w(MIT-LICENSE raki.gemspec Rakefile README.rdoc SPEC.rdoc)

  s.bindir = 'bin'
  s.require_path = 'lib'
  s.extra_rdoc_files = ['README.rdoc', 'CHANGELOG.md', 'CONTRIBUTING.md']

  s.author = 'Dittmar Krall'
  s.email = 'dittmar.krall@matique.de'

  s.homepage = 'https://matique.com'

  s.required_ruby_version = '>= 2.6.0'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'

  s.add_development_dependency 'minitest', "~> 5.0"
  s.add_development_dependency 'minitest-sprint'
  s.add_development_dependency 'minitest-global_expectations'
end

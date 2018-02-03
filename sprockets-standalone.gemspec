# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprockets/standalone/version'

Gem::Specification.new do |spec|
  spec.name          = "sprockets-standalone"
  spec.version       = Sprockets::Standalone::VERSION
  spec.authors       = ["Jan Graichen"]
  spec.email         = ["jg@altimos.de"]
  spec.summary       = %q{Rack task library for using Sprockets standalone.}
  spec.description   = %q{Rack task library for using Sprockets standalone.}
  spec.homepage      = "https://github.com/jgraichen/sprockets-standalone"
  spec.license       = "MIT"

  spec.files         = Dir["**/*"].grep(%r{^((bin|lib|spec)/|.*\.gemspec|.*LICENSE.*|.*README.*)})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"
  spec.add_dependency "sprockets", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.4"
end

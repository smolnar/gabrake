# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gabrake/version'

Gem::Specification.new do |spec|
  spec.name          = 'gabrake'
  spec.version       = Gabrake::VERSION
  spec.authors       = ['Samuel Molnar']
  spec.email         = ['molnar.samuel@gmail.com']

  spec.summary       = 'Simple Realtime Error Tracking and Statistics with Google Analytics'
  spec.description   = 'Simple Realtime Error Tracking and Statistics with Google Analytics'
  spec.homepage      = 'htts://github.com/smolnar/gabrake'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'railties', '>= 3.2.0'
  spec.add_dependency 'rails', '>= 3.2.0'
  spec.add_dependency 'httparty', '~> 0.13.5'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end

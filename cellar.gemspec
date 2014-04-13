# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cellar/version'

Gem::Specification.new do |spec|
  spec.name          = "cellar"
  spec.version       = Cellar::VERSION
  spec.authors       = ["Dmitry Grach"]
  spec.email         = ["dmitrygrach@gmail.com"]
  spec.summary       = %q{fast multisiting.}
  spec.description   = %q{Multisiting platform with safe Mustache templates,
                          Postgresql document-models and rich JSON API.}
  spec.homepage      = "http://github.com/cawcaw/cellar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '~> 1.4.4'
  spec.add_dependency 'mustache'
  spec.add_dependency 'sass'
  spec.add_dependency 'pg'
  spec.add_dependency 'sequel'
  spec.add_dependency 'json'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end

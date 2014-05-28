# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cellar/version'

Gem::Specification.new do |spec|
  spec.name          = 'cellar'
  spec.version       = Cellar::VERSION
  spec.authors       = ["Dmitry Grach"]
  spec.email         = ["dmitrygrach@gmail.com"]
  spec.summary       = %q{fast multisiting.}
  spec.description   = %q{Multisiting platform with safe Mustache templates,
                          Postgresql document-models. deep beta.}
  spec.homepage      = "http://github.com/cawcaw/cellar"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '~> 1.4.4'
  spec.add_dependency 'mustache'
  spec.add_dependency 'pg'
  spec.add_dependency 'sequel'
  spec.add_dependency 'json'
  spec.add_dependency 'rake'
  spec.add_dependency 'warden'
  spec.add_dependency 'bcrypt'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sass'
end

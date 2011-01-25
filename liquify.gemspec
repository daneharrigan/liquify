# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "liquify/version"

Gem::Specification.new do |s|
  s.name        = "liquify"
  s.version     = Liquify::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dane Harrigan"]
  s.email       = ["dane.harrigan@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A wrapper for Liquid Markup to make it easier to use}
  s.description = s.summary

  s.rubyforge_project = "liquify"
  s.add_dependency 'liquid', '>= 2.2.2'
  s.add_development_dependency 'rspec', '~> 2.3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

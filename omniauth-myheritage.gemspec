# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/my_heritage/version'

Gem::Specification.new do |s|
  s.name     = 'omniauth-myheritage'
  s.version  = OmniAuth::MyHeritage::VERSION
  s.authors  = ['Michael Berkovich']
  s.email    = ['theiceberk@gmail.com']
  s.summary  = 'MyHeritage strategy for OmniAuth'
  s.homepage = 'https://github.com/geni/omniauth-myheritage'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.0.0'

  s.add_development_dependency 'rspec', '~> 2.7.0'
  s.add_development_dependency 'rake'
end

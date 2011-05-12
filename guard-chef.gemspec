# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'guard/chef/version'

Gem::Specification.new do |s|
  s.name        = 'guard-chef'
  s.version     = Guard::ChefVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Dreamr OKelly']
  s.email       = ['james@rubyloves.me']
  s.homepage    = 'http://rubygems.org/gems/guard-chef'
  s.summary     = 'Guard gem for Chef'
  s.description = 'Guard::Chef allows to automatically & intelligently update roles, cookbooks, and databags for chef.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'guard-chef'

  s.add_dependency 'guard', '>= 0.2.2'

  s.add_development_dependency 'bundler', '~> 1.0.2'
  s.add_development_dependency 'rspec',   '~> 2.0.1'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.rdoc]
  s.require_path = 'lib'

  s.rdoc_options = ["--charset=UTF-8", "--main=README.rdoc", "--exclude='(lib|test|spec)|(Gem|Guard|Rake)file'"]
end
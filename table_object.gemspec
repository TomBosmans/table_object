# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'table_object/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'table_object'
  s.version     = TableObject::VERSION
  s.authors     = ['TomBosmans']
  s.email       = ['tom.94.bosmans@gmail.com']
  s.homepage    = 'https://github.com/TomBosmans/table_object'
  s.summary     = 'Generate HTML tables with ruby'
  s.description = 'Generate HTML tables by creating ruby classes.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.0.rc2'

  s.add_development_dependency 'sqlite3'
end

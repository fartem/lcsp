# frozen_string_literal: true

require 'English'

::Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.0'
  s.name = 'lcsp'
  s.version = '1.2.2'
  s.license = 'MIT'
  s.files = ::Dir['lib/**/*.rb'] + %w[bin/lcsp bin/cli.rb README.md LICENSE]
  s.executable = 'lcsp'
  s.require_paths << 'lib'
  s.summary = 'A tool for showing solutions from LeetCode'
  s.authors = ['Artem Fomchenkov']
  s.email = 'artem.fomchenkov@outlook.com'
  s.homepage = 'https://github.com/fartem/lcsp'
  s.test_files = s.files.grep(%r{^(test)/})
  s.extra_rdoc_files = ['README.md']

  s.add_runtime_dependency('dry-cli', '1.0.0')
  s.add_runtime_dependency('faraday', '2.7.4')
  s.add_runtime_dependency('git', '1.18')
  s.add_runtime_dependency('rouge', '4.1.0')

  s.add_development_dependency('minitest', '5.18.0')
  s.add_development_dependency('rake', '12.3.3')
  s.add_development_dependency('rubocop', '1.7.0')
  s.add_development_dependency('simplecov', '0.22.0')
end

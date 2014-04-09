require File.expand_path('../lib/fnby/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'fnby'
  s.homepage    = 'https://github.com/obfusk/fnby'
  s.summary     = '...'

  s.description = <<-END.gsub(/^ {4}/, '')
    ...
  END

  s.version     = Fnby::VERSION
  s.date        = Fnby::DATE

  s.authors     = [ 'Felix C. Stegerman' ]
  s.email       = %w{ flx@obfusk.net }

  s.licenses    = %w{ LGPLv3+ }

  s.files       = %w{ .yardopts README.md Rakefile } \
                + %w{ fnby.gemspec } \
                + Dir['{lib,spec}/**/*.{rb,tt}']

  s.add_runtime_dependency 'treetop'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.required_ruby_version = '>= 1.9.1'
end

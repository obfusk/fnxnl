require File.expand_path('../lib/rb/fnxnl/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'fnxnl'
  s.homepage      = 'https://github.com/obfusk/fnxnl'
  s.summary       = '...'

  s.description   = <<-END.gsub(/^ {4}/, '')
    ...
  END

  s.version       = Fnxnl::VERSION
  s.date          = Fnxnl::DATE

  s.authors       = [ 'Felix C. Stegerman' ]
  s.email         = %w{ flx@obfusk.net }

  s.licenses      = %w{ LGPLv3+ }

  s.require_path  = 'lib/rb'

  s.files         = %w{ .yardopts README.md Rakefile } \
                  + %w{ fnxnl.gemspec } \
                  + Dir['{lib,spec}/rb/**/*.{rb,tt}']

  s.add_runtime_dependency 'treetop'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.required_ruby_version = '>= 1.9.1'
end

# --                                                            ; {{{1
#
# File        : fnby/parser.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-04-08
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

require 'set'
require 'treetop'

module Fnby; module Parser

  class ParseFailed < RuntimeError; end

  class Sym                                                     # {{{1
    attr_reader :value
    def initialize(value)
      @value = value.to_sym; freeze
    end
    def to_s
      "#<Sym: #{value}>"
    end
    alias :inspect :to_s
  end                                                           # }}}1

  class List < Array                                            # {{{1
    def initialize(*xs)
      replace xs; freeze
    end
    def to_s
      "#<List: #{super.to_s}>"
    end
    alias :inspect :to_s
  end                                                           # }}}1

  class Vector < Array                                          # {{{1
    def initialize(*xs)
      replace xs; freeze
    end
    def to_s
      "#<Vector: #{super.to_s}>"
    end
    alias :inspect :to_s
  end                                                           # }}}1

  class Lambda                                                  # {{{1
    attr_reader :tokens
    def initialize(tokens)
      @tokens = tokens; freeze
    end
    def to_s
      "#<Lambda: #{tokens.to_s}>"
    end
    alias :inspect :to_s
  end                                                           # }}}1

  class Quote                                                   # {{{1
    attr_reader :token
    def initialize(token)
      @token = token; freeze
    end
    def to_s
      "#<Quote: #{token.to_s}>"
    end
    alias :inspect :to_s
  end                                                           # }}}1

  Treetop.load File.expand_path('../parser.tt', __FILE__)

  def self.parse(data)
    p = FnbyParser.new
    r = p.parse(data) or raise ParseFailed, p.failure_reason
    r.value
  end

  def self.parse_file(filename)
    parse File.read(filename)
  end

end; end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :

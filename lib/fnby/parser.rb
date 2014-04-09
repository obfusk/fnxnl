# --                                                            ; {{{1
#
# File        : fnby/parser.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-04-09
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

require 'fnby/data'
require 'treetop'

module Fnby; module Parser

  class ParseFailed < RuntimeError; end

  Treetop.load File.expand_path('../parser.tt', __FILE__)

  def self.parse(data)
    p = FnbyParser.new
    r = p.parse(data) or raise ParseFailed, p.failure_reason
    r.to_data
  end

  def self.parse_file(filename)
    parse File.read(filename)
  end

end; end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :

# --                                                            ; {{{1
#
# File        : fnxnl/parser.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-04-18
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

require 'fnxnl/data'
require 'treetop'

module Fnxnl; module Parser

  class ParseFailed < RuntimeError; end

  Treetop.load File.expand_path('../parser.tt', __FILE__)

  def self.parse(data)
    p = FnxnlParser.new
    r = p.parse(data) or raise ParseFailed, p.failure_reason
    r.to_data
  end

  def self.parse_file(filename)
    parse File.read(filename)
  end

end; end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :

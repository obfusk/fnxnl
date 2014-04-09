# --                                                            ; {{{1
#
# File        : fnby/data.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-04-09
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

module Fnby; module Data

  class Node
    attr_reader :value
    def initialize(value)
      @value = value; freeze
    end
    def to_s
      "#<#{self.class.name}: #{value}>"
    end
    def == (rhs)
      value == rhs.value
    end
    alias :inspect :to_s
  end

  class Symbol  < Node; end
  class List    < Node; end
  class Vector  < Node; end
  class Map     < Node; end
  class Set     < Node; end
  class Lambda  < Node; end
  class Quote   < Node; end

end; end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :

# --                                                            ; {{{1
#
# File        : fnby/parser_spec.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-04-09
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

require 'fnby/parser'

fp = Fnby::Parser
fd = Fnby::Data

describe 'fnby/parser' do

  context 'parse' do
    it 'parses symbols' do
      %w{ foo bar-%-baz!? }.each do |x|
        expect(fp.parse(x)).to eq([fd::Symbol.new(x.to_sym)])
      end
    end
    it 'parses keywords' do
      %w{ foo bar-%-baz!? 42 2isOK }.each do |x|
        expect(fp.parse(':'+x)).to eq([x.to_sym])
      end
    end
    it 'parses strings' do                                      # {{{1
      expect(fp.parse('"foo"')      ).to eq(['foo'])
      expect(fp.parse('"foo\"..."') ).to eq(['foo"...'])
      expect(fp.parse('"foo\u1234"')).to eq(["foo\u1234"])
      expect(fp.parse('"foo\x00"')  ).to eq(["foo\x00"])
      expect(fp.parse('"foo\010"')  ).to eq(["foo\010"])
      expect(fp.parse('"foo\\\\"')  ).to eq(["foo\\"])
      expect(fp.parse('"foo\0"')    ).to eq(["foo\0"])
      expect(fp.parse('"foo\a"')    ).to eq(["foo\a"])
      expect(fp.parse('"foo\b"')    ).to eq(["foo\b"])
      expect(fp.parse('"foo\f"')    ).to eq(["foo\f"])
      expect(fp.parse('"foo\n"')    ).to eq(["foo\n"])
      expect(fp.parse('"foo\r"')    ).to eq(["foo\r"])
      expect(fp.parse('"foo\t"')    ).to eq(["foo\t"])
      expect(fp.parse('"foo\v"')    ).to eq(["foo\v"])
      expect(fp.parse('"foo\OK"')   ).to eq(["fooOK"])
    end                                                         # }}}1
    it 'parses regexes' do
      expect(fp.parse('#"(foo|bar)*"')).to eq([/(foo|bar)*/])
    end
    it 'parses floats' do                                       # {{{1
      expect(fp.parse('-42.'  )).to eq([-42.0])
      expect(fp.parse('.37'   )).to eq([0.37])
      expect(fp.parse('9.9'   )).to eq([9.9])
      expect(fp.parse('-2e17' )).to eq([-2e17])
      expect(fp.parse('2.e-3' )).to eq([2e-3])
    end                                                         # }}}1
    it 'parses rationals' do
      expect(fp.parse('+37/-42')).to eq([Rational(-37,42)])
    end
    it 'parses integers' do                                     # {{{1
      expect(fp.parse('-42'   )).to eq([-42])
      expect(fp.parse('+37'   )).to eq([37])
      expect(fp.parse('100'   )).to eq([100])
      expect(fp.parse('-2r111')).to eq([-7])
      expect(fp.parse('010'   )).to eq([8])
      expect(fp.parse('0xff'  )).to eq([255])
      expect(fp.parse('36rzz' )).to eq([1295])
    end                                                         # }}}1
    it 'parses booleans' do
      expect(fp.parse('true' )).to eq([true])
      expect(fp.parse('false')).to eq([false])
    end
    it 'parses nil' do
      expect(fp.parse('nil')).to eq([nil])
    end
    it 'parses lists' do
      expect(fp.parse('(+ 1 (2 3) 4)')).to \
        eq([fd::List.new([fd::Symbol.new(:+), 1, fd::List.new([2,3]), 4])])
    end
    it 'parses vectors' do
      expect(fp.parse('[:x (2 3) :y]')).to \
        eq([fd::Vector.new([:x, fd::List.new([2,3]), :y])])
    end
    it 'parses maps' do
      expect(fp.parse('{:x 1,:y 2}')).to \
        eq([fd::Map.new([:x, 1, :y, 2])])
    end
    it 'parses sets' do
      expect(fp.parse('#{ 1 2 3 }')).to \
        eq([fd::Set.new([1,2,3])])
    end
    it 'parses lambdas' do
      expect(fp.parse('#(+ %1 %2)')).to \
        eq([fd::Lambda.new([fd::Symbol.new(:+),
                            fd::Symbol.new(:'%1'),
                            fd::Symbol.new(:'%2')])])
    end
    it 'parses quotes' do
      expect(fp.parse(%q{'()})).to \
        eq([fd::Quote.new(fd::List.new([]))])
    end
    it 'parses complex structures' do                           # {{{1
      a = %q{
        ()  ; comment
            ; ...
        42
        (fn [a b]
          (foo { :x (+ a 1) } :y (* 2 b) ))
      }
      b = [
        fd::List.new([]), 42,
        fd::List.new([
          fd::Symbol.new(:fn), fd::Vector.new([fd::Symbol.new(:a),
                                               fd::Symbol.new(:b)]),
          fd::List.new([fd::Symbol.new(:foo),
            fd::Map.new([:x, fd::List.new([fd::Symbol.new(:+),
                                           fd::Symbol.new(:a), 1])]),
            :y, fd::List.new([fd::Symbol.new(:*), 2, fd::Symbol.new(:b)])
          ])
        ])
      ]
      expect(fp.parse(a)).to eq(b)
    end                                                         # }}}1
  end

end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :

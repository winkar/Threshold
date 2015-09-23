module Threshold

  require 'test/unit'
  require_relative '../Scanner'
  require 'stringio'

  class ScannerTest  < Test::Unit::TestCase
    def test1
      test_code = 'abcdefghijk'
      scanner = Scanner.new (StringIO.new test_code)
      assert_equal('de', scanner.drop_while { |c| c < 'd' }.take(2).to_a.join(''))
      assert_equal('e', scanner.last_char)
      assert_equal('fghi', scanner.take_while { |c| c < 'j' }.to_a.join(''))
      assert_equal('j', scanner.last_char)
    end
  end



end

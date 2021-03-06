module Threshold

  require 'test/unit'
  require_relative '../Lexer'
  require 'stringio'

  class LexerTest < Test::Unit::TestCase

    def check_token(token, type, value=nil)
      assert_equal(type, token.type)
      assert_equal(value, token.value)
    end

    def test1
      test_code = <<-EOF
        def asdad
          123
          (123.123)
      EOF

      lexer = Lexer.new (StringIO.new test_code)
      check_token(lexer.get_next_token, :Def)
      check_token(lexer.get_next_token, :Identifier, 'asdad')
      check_token(lexer.get_next_token, :Integer, 123)
      check_token(lexer.get_next_token, :LeftParenthesis)
      check_token(lexer.get_next_token, :Double, 123.123)
      check_token(lexer.get_next_token, :RightParenthesis)
      check_token(lexer.get_next_token, :EOF)
    end
  end

end

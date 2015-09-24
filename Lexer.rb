module Threshold
  require_relative 'Token'
  require_relative 'Utils'
  require_relative 'Scanner'

  class Lexer
    attr_reader :current_token

    def initialize(input)
      @scanner = Scanner.new(input)
    end

    def get_next_token

      first_char = @scanner.last_char
      while @scanner.last_char.is_space?
        first_char = @scanner.take(1).to_a[0]
      end

      # Identifier: [a-zA-Z_][a-zA-z0-9_]*
      if first_char.is_alpha? || first_char == '_'
        identifierStr = first_char + @scanner.take_while {|c| c.is_alpha_numeric? || c=='_'} .to_a.join('')

        if identifierStr == 'def'
          @current_token = Token.new(:Def)
        else
          @current_token = Token.new(:Identifier, identifierStr)
        end


      # Double: [0-9]+\.[0-9]+
      # Integer: [0-9]+
      elsif first_char.is_numeric?
        numberStr = first_char + @scanner.take_while {|c| c.is_numeric? || c=='.'}.to_a.join('')
        dot_found = numberStr.scan(/\./).length

        if dot_found > 0
          if dot_found > 1 then raise 'Double litral can only contain one dot.' end
          @current_token = Token.new(:Double, numberStr.to_f)
        else
          @current_token = Token.new(:Integer, numberStr.to_i)
        end

      # Comment
      elsif first_char == '#'
        @scanner.take_until { |c| c=='\n' }
        @current_token =  get_next_char
      elsif first_char == nil
        @current_token = Token.new(:EOF)
      end

    end
  end
end

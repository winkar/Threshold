module Threshold
  class Token
    EOF = -1
    Double = -2
    Integer = -3
    Identifier = -4
    Def = -5

    attr_reader :type
    attr_reader :value

    def initialize(type, value=nil)
      if !Token.constants.include?(type)
        raise "Token type not found! #{type}"
      end
      @type = type
      @value = value
    end
  end
end

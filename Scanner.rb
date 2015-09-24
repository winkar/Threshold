module Threshold
  require_relative 'Utils'

  class EnumerableWrapper
    include Enumerable

    def initialize(ref)
      @ref = ref
    end

    def each(&block)
      loop {
        yield @ref.each(&block)
      }
    end
  end

  class Scanner

    Enumerable.instance_methods.each do |name|
      define_method(name) do |*args, &block|
        if name != :lazy
          if name == :take
            res = @wrapper.lazy.send(name, *args, &block).to_a
            if  res.length == 1 then res[0] else res end
          else
            @wrapper.lazy.send(name, *args, &block)
          end
        end
      end
    end

    attr_reader :last_char


    def initialize(infile = nil)
      @wrapper = EnumerableWrapper.new self
      @in = infile || STDIN
      @last_char = ' '
      @line = 0
      @column = 0
    end

    def get_next_char
      @last_char = @in.read(1)

      if @last_char == nil
        self.handle_eof
      end


      if @last_char == '\n'
          @line += 1
          @column = 0
      else
        @column += 1
      end

      @last_char
    end


    def each
      while true
        yield self.get_next_char
      end
    end

    def handle_eof
      raise EOFError
    end
  end

end

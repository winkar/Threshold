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
    # include Enumerable

    Enumerable.instance_methods.each do |name|
      define_method(name) do |*args, &block|
        if name != :lazy
          @wrapper.lazy.send(name, *args, &block)
        end
      end
    end

    attr_reader :LastChar



    def initialize(infile = nil)
      @wrapper = EnumerableWrapper.new self
      @In = infile || STDIN
      @LastChar = ''
      @Line = 0
      @Column = 0
    end

    def get_next_char
        @LastChar = @In.read(1)

        if @LastChar == nil
          self.handle_eof
        end

        while @LastChar.is_space? do
            @LastChar = @In.read(1)
        end


        if @LastChar == '\n'
            @Line += 1
            @Column = 0
        else
          @Column += 1
        end

        @LastChar
    end


    def each
      begin
        while true
          yield self.get_next_char
        end
      rescue EOFError
        nil
      end
    end

    def handle_eof
      raise EOFError
    end
  end

end

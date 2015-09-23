module Threshold
  class Token < Enum
    enum_attr :EOF
    enum_attr :Double
    enum_attr :Integer
    enum_attr :Identifier
  end
end

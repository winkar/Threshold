class String
  def is_alpha?
    self.length == 1 && self =~ /[[:alpha:]]/
  end
  def is_numeric?
    self.length == 1 && self =~ /[[:digit:]]/
  end

  def is_alpha_numeric?
    self.length == 1 && (self.is_alpha? || self.is_numeric?)
  end

  def is_space?
    self.length == 1 && self =~ /[[:space:]]/
  end
end

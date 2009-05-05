class Expectation
  attr_reader :ret_val
  
  def receives method
    @method = method
    self
  end
  
  def with *args
    @args = args
    self
  end

  def return value
    @ret_val = value
  end
  
  def matches? method, *args
    return false unless method == @method
    return true unless @args
    @args == args
  end
end
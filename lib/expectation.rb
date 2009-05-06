class Expectation
  attr_reader :ret_val, :should_yield, :yield_val
  
  def initialize
    @should_yield = false
  end
  
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
  
  def yield value
    @should_yield = true
    @yield_val = value
  end
  
  def matches? method, *args
    return false unless method == @method
    return true unless @args
    @args == args
  end
end
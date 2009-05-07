require 'orangutan/raiser'
require 'orangutan/container'

class Orangutan::Expectation
  attr_reader :return_value, :yield_container, :raiser
  
  def receives method
    @method = method
    self
  end
  
  def with *args
    @args = args
    self
  end

  def return value
    @return_value = value
    self
  end
  
  def yield value
    @yield_container = Orangutan::Container.new value
    self
  end
  
  def raise *args
    @raiser = Orangutan::Raiser.new args
    self
  end

  def matches? method, *args
    return false unless method == @method
    return true unless @args
    @args == args
  end
end
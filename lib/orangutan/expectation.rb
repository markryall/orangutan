require 'orangutan/raiser'
require 'orangutan/container'

module Orangutan
  class Expectation
    attr_reader :return_container, :yield_container, :raiser
    
    def receives method
      @method = method
      self
    end
    
    def with *args
      @args = args
      self
    end
  
    def return *value
      @return_container = Container.new value
      self
    end
    
    def yield *value
      @yield_container = Container.new value
      self
    end
    
    def raise *args
      @raiser = Raiser.new args
      self
    end
  
    def matches? method, *args
      return false unless method == @method
      return true unless @args
      @args == args
    end
  end
end
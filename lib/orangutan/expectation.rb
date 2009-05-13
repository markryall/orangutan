require 'orangutan/raiser'
require 'orangutan/container'

module Orangutan
  class Expectation
    attr_reader :return_container, :yield_container, :raiser, :count
    
    def initialize
      @return_container = nil
      @yield_container = nil
      @raiser = nil
    end
    
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
      matched = @args ? @args == args : true
      return false if @limit && @count && @count >= @limit
      if matched
        @count ||= 0
        @count += 1
      end
      matched
    end

    def exactly count
      @limit = count
      self
    end

    def once
      exactly 1
    end

    def twice
      exactly 2
    end

    def times
      self
    end
    
    def matched?
      if @limit
        @count && @count >= @limit
      else
        @count
      end 
    end
  end
end
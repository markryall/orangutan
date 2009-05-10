module Orangutan
  class StubBase
    instance_methods.each { |m| undef_method m unless m =~ /^__/ }

    def initialize name, parent, recursive=false
      @name, @parent, @recursive = name, parent, recursive
    end

    def method_missing method, *args
      yield_container, return_container = __react__(method, args)
      yield yield_container.value if yield_container && block_given?
      __return__(method, return_container)
    end
  private
    def __return__ method, return_container
      return return_container.value if return_container
      return @parent.stub(:"#{@name}/#{method}") if @recursive
      nil
    end
  
    def __react__ method, args
      yield_container, return_container = nil, nil
      @parent.calls << Call.new(@name, method, args)
      first_match = @parent.first_match(@name, method, args)
      if first_match
        first_match.raiser.execute if first_match.raiser
        yield_container, return_container =  first_match.yield_container, first_match.return_container
      end
      return yield_container, return_container
    end
  end
end
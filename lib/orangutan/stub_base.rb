require 'orangutan/stub_include'

module Orangutan
  class StubBase    
    instance_methods.each { |m| undef_method m unless m =~ /^__/ }

    include StubInclude

    def initialize name, parent, recursive=false
      @name, @parent, @recursive = name, parent, recursive
    end

    def method_missing method, *args
      yield_container, return_container = __react__(method, args)
      if yield_container && block_given?
        yield_container.value.each {|v| yield *v }
      end
      __return__(method, return_container)
    end
  end
end
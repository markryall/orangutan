require 'orangutan/stub_base'
require 'orangutan/expectation'
require 'orangutan/call'
require 'orangutan/reflector'

module Orangutan 
  class Chantek
    attr_reader :calls, :stubs, :expectations
  
    def initialize
      @calls = []
      @expectations = {}
      @stubs= {}
    end
  
    def stub name, params={}
      return @stubs[name] if @stubs[name]
      c = Class.new(StubBase)
      implement_interface c, params[:clr_interface]
      @stubs[name] = c.new(name, self, params[:recursive])
    end

    def implement_interface clazz, interface
      return unless interface
      reflector = Reflector.new(interface)
      clazz.instance_eval do
        include interface

        reflector.methods.each do |name|
          define_method name do |*args|
            yield_container, return_container = __react__(name, args)
            if yield_container && block_given?
              yield_container.value.each {|v| yield *v }
            end
            return __return__(method, return_container)
          end
        end
      end
    end

    def when name
      expectations_for_name = @expectations[name]
      @expectations[name] = expectations_for_name = [] unless expectations_for_name
      expectation = Orangutan::Expectation.new
      expectations_for_name << expectation
      expectation
    end
  
    def first_match name, method, args
      expectations_for_name = @expectations[name]
      if expectations_for_name
        expectations_for_name.each do |expectation|
            return expectation if expectation.matches?(method, *args)
        end
      end
      nil
    end

    def fire_event name, event, *args
    end
  end
end
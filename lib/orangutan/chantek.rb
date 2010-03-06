require 'orangutan/object_extensions'
require 'orangutan/stub_base'
require 'orangutan/expectation'
require 'orangutan/call'
require 'orangutan/reflector'
require 'orangutan/stub_include'

module Orangutan 
  module Chantek
    attr_reader :calls, :stubs, :expectations

    def call name, method, *args
      Call.new(name, method, args)
    end

    def reset_stubs
      @calls = []
      @expectations = {}
      @stubs= {}
      @events = {}
      @stubbed_methods = []
    end

    def register_object name, object
      @stubs[name] ||= object
    end

    def stub_method name, method
      object = @stubs[name]
      raise "could not find an object registered with the name #{name}" unless object
      chantek = self
      object.instance_eval do
        @parent = chantek
        @name = name
      end
      @stubbed_methods << [name, method]
      object.eigen_eval do
        alias_method("__unstubbed_#{method}", method)
      end
      implement_method object.eigen, method
    end
    
    def restore_method name, method
      @stubs[name].eigen_eval do
        alias_method(method, "__unstubbed_#{method}")
      end
      @stubbed_methods.delete [name, method]
    end

    def restore_methods
      @stubbed_methods.each {|tuple| restore_method tuple[0], tuple[1]}
    end

    def stub name, params={}
      return @stubs[name] if @stubs[name]
      clazz = Class.new(StubBase)
      @events[name] = {}
      implement_interface clazz, params[:clr_interface], @events[name]
      @stubs[name] = clazz.new(name, self, params[:recursive])
    end

    def implement_interface clazz, interface, events
      return unless interface
      reflector = Reflector.new(interface)
      clazz.instance_eval { include interface }
      reflector.methods.each {|method| implement_method clazz, method }
      reflector.events.each do |event|
        events[event] = []
        implement_event clazz, event, events[event]
      end
    end

    def implement_method clazz, name
      clazz.instance_eval do
        include StubInclude

        define_method name do |*args|
          yield_container, return_container = __react__(name, args)
          yield_container.value.each {|v| yield *v } if yield_container && block_given?
          return __return__(name, return_container)
        end
      end
    end

    def implement_event clazz, name, delegates
      method = "add_#{name}".to_sym
      clazz.instance_eval do
        define_method method  do |delegate|
          __react__(method, [])
          delegates << delegate
        end
      end
    end

    def so_when name
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
      events_for_name = @events[name]
      raise "failed to find any events for #{name}" unless events_for_name
      # it makes no sense, but 'events_for_name[event]' returns nil so in desperation, we iterate over the events
      events_for_name.each do |event_name,delegates|
        delegates.each { |delegate| delegate.invoke *args } if event_name == event
      end
    end
  end
end
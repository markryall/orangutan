require 'orangutan/stub_base'
require 'orangutan/expectation'
require 'orangutan/call'

module Orangutan 
  class Chantek
    attr_reader :calls
  
    def initialize
      @calls = []
      @expectations = {}
      @stubs= {}
    end
  
    def stub name, params={}
      return @stubs[name] if @stubs[name]
      c = Class.new(StubBase) do
        if params[:clr_interface]
          include params[:clr_interface]
          params[:clr_interface].to_clr_type.get_methods.each do |m_info|
            snake = m_info.name.scan(/[A-Z][a-z0-9]*/).map {|a|a.downcase}.join('_').to_sym
            define_method snake do |*args|
              yield_container, return_container = __react__(snake, args)
              yield yield_container.value if yield_container && block_given?
              __return__(method, return_container)
            end
          end
        end
      end
      @stubs[name] = c.new(name, self, params[:recursive])
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
    end
  end
end
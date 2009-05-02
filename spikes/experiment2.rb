# demonstrates mocking clr interfaces by dynamically creating an implementation using reflection

require 'consumer'

class Orangutan
  Call = Struct.new(:name, :method, :args)

  attr_reader :calls

  def initialize
    @calls = []
  end

  def stub name, clr_interface
    c = Class.new do
      include clr_interface

      def initialize name, calls
        @name, @calls = name, calls
      end

      def method_missing method, *args
        @calls << Call.new(@name, method, args)
      end

      clr_interface.to_clr_type.get_methods.each do |m_info|
        snake = m_info.name.scan(/[A-Z][a-z]*/).map {|a|a.downcase}.join('_')
        define_method snake do |*args|
          @calls << Call.new(@name, snake, args)
        end
      end
    end
    c.new name, @calls
  end
end

o = Orangutan.new
m1 = o.stub 'mock1', ClassLibrary::IConsumable
m2 = o.stub 'mock2', System::IDisposable
$consumer.consume(m1)
m1.foo 1,2,3
m1.bar 5,6,7
m2.dispose
puts o.calls.inspect

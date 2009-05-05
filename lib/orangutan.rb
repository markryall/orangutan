require 'clean_slate'
require 'expectation'

class Orangutan
  attr_reader :calls

  Call = Struct.new(:name, :method, :args)

  def initialize
    @calls = []
    @expectations = {}
  end

  def stub name, params={}
    c = Class.new(CleanSlate) do
      if params[:interface]
        include params[:interface]
        params[:interface].to_clr_type.get_methods.each do |m_info|
          snake = m_info.name.scan(/[A-Z][a-z0-9]*/).map {|a|a.downcase}.join('_').to_sym
          define_method snake do |*args|
            __react__ snake, args
          end
        end
      end

      def initialize name, parent
        @name, @parent = name, parent
      end

      def method_missing method, *args
        __react__ method, args
      end
      private
      def __react__ method, args
        @parent.calls << Call.new(@name, method, args)
        @parent.return(@name, method, args)
      end
    end
    c.new name, self
  end

  def when name
    expectations_for_name = @expectations[name]
    @expectations[name] = expectations_for_name = [] unless expectations_for_name
    e = Expectation.new name
    expectations_for_name << e
    e
  end
  
  def return name, method, args
    expectations_for_name = @expectations[name]
    if expectations_for_name
      expectations_for_name.each do |exp|
        if exp.matches?(method, *args)
          return exp.ret_val
        end
      end
    end
  end
end
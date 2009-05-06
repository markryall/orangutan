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
            y,r = __react__ snake, args
            yield y if y && block_given?
            r
          end
        end
      end

      def initialize name, parent
        @name, @parent = name, parent
      end

      def method_missing method, *args
        y,r = __react__ method, args
        yield y if y && block_given?
        r
      end

  private

      def __react__ method, args
        y,r=nil
        @parent.calls << Call.new(@name, method, args)
        f = @parent.first_match(@name, method, args)
        if f
          y = f.yield_val if f.should_yield
          r = f.ret_val
        end
        return y,r
      end
    end
    c.new name, self
  end

  def when name
    expectations_for_name = @expectations[name]
    @expectations[name] = expectations_for_name = [] unless expectations_for_name
    e = Expectation.new
    expectations_for_name << e
    e
  end

  def first_match name, method, args
    expectations_for_name = @expectations[name]
    if expectations_for_name
      expectations_for_name.each do |exp|
          return exp if exp.matches?(method, *args)
      end
    end
  end
end
require 'orangutan/clean_slate'
require 'orangutan/expectation'
require 'orangutan/call'

class Orangutan::Chantek
  attr_reader :calls

  def initialize
    @calls = []
    @expectations = {}
  end

  def stub name, params={}
    c = Class.new(Orangutan::CleanSlate) do
      if params[:interface]
        include params[:interface]
        params[:interface].to_clr_type.get_methods.each do |m_info|
          snake = m_info.name.scan(/[A-Z][a-z0-9]*/).map {|a|a.downcase}.join('_').to_sym
          define_method snake do |*args|
            yield_container, return_value, raiser = __react__ snake, args
            raiser.execute if raiser
            yield yield_container.value if yield_container && block_given?
            return_value
          end
        end
      end

      def initialize name, parent
        @name, @parent = name, parent
      end

      def method_missing method, *args
        yield_container, return_value, raiser = __react__ method, args
        raiser.execute if raiser
        yield yield_container.value if yield_container && block_given?
        return_value
      end

  private

      def __react__ method, args
        yield_container, return_value, raiser = nil, nil, nil
        @parent.calls << Orangutan::Call.new(@name, method, args)
        first_match = @parent.first_match(@name, method, args)
        return first_match.yield_container, first_match.return_value, first_match.raiser if first_match
        return yield_container, return_value, raiser
      end
    end
    c.new name, self
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
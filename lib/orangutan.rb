require 'clean_slate'

class Orangutan
  attr_reader :calls

  Call = Struct.new(:name, :method, :args)

  def initialize
    @calls = []
  end

  def stub name, params={}
    c = Class.new(CleanSlate) do
      if params[:interface]
        include params[:interface]
        params[:interface].to_clr_type.get_methods.each do |m_info|
          snake = m_info.name.scan(/[A-Z][a-z0-9]*/).map {|a|a.downcase}.join('_').to_sym
          define_method snake do |*args|
            @parent.calls << Call.new(@name, snake, args)
          end
        end
      end

      def initialize name, parent
        @name, @parent = name, parent
      end

      def method_missing method, *args, &block
        @parent.calls << Call.new(@name, method, args)
      end
    end
    c.new name, self
  end
end
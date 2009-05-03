class Orangutan
  attr_reader :calls

  Call = Struct.new(:name, :method, :args)

  def initialize
    @calls = []
  end

  def stub name
    c = Class.new do
      def initialize name, calls
        @name, @calls = name, calls
      end

      def method_missing method, *args
        @calls << Call.new(@name, method, args)
      end
    end
    c.new name, @calls
  end
end

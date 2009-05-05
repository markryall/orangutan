require 'orangutan'
require 'ClassLibrary.dll'

describe Orangutan do
  before do
    @o = Orangutan.new
  end

  it 'should record method calls and their parameters on a stub' do
    s = @o.stub 'foo'
    s.method1(1,2,3)
    s.calls[0].should == Orangutan::Call.new('foo', :method1, [1,2,3])
  end

  it 'should record all ordinary object methods calls (except __send__ and __id__)' do
    s = @o.stub 'foo'
    methods = Object.new.methods
    count = methods.length
    methods.each do |m|
      s.__send__(m.to_sym) unless m =~ /^__/
    end
    @o.calls.length.should == (methods.length-2)
  end

  it 'should create stub implementations of a clr interface with a method' do
    s = @o.stub 'foo', :interface => ClassLibrary::IHaveAMethod
    c = ClassLibrary::Consumer.new
    c.call_method(s) 
    @o.calls[0].should == Orangutan::Call.new('foo', :my_method, ['thing'])
  end
end
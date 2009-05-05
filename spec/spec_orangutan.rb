require 'orangutan'

describe Orangutan, 'creating ruby stubs' do
  before do
    @o = Orangutan.new
    @s = @o.stub :foo
  end

  it 'should record method calls and their parameters on a stub' do
    @s.method1(1,2,3)
    @o.calls[0].should == Orangutan::Call.new(:foo, :method1, [1,2,3])
  end

  it 'should record all ordinary object methods calls (except __send__ and __id__)' do
    methods = Object.new.methods
    methods.each { |m| @s.__send__(m.to_sym) unless m =~ /^__/ }
    @o.calls.length.should == (methods.length-2)
  end

  it 'should allow method return values to be stubbed' do
    @o.when(:foo).receives(:bar).return('baz')
    @s.bar.should == 'baz'
  end

  it 'should allow method return values to be stubbed for method invocations with specific arguments' do
    @o.when(:foo).receives(:bar).with(7).return('baz')
    @s.bar(7).should == 'baz'
  end
end
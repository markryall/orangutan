require 'orangutan'

describe Orangutan::Chantek, 'creating ruby stubs' do
  before do
    @o = Orangutan::Chantek.new
    @foo = @o.stub :foo
  end

  it 'should record method calls and their parameters on a stub' do
    @foo.method1(1,2,3)
    @o.calls[0].should == Orangutan::Call.new(:foo, :method1, [1,2,3])
  end

  it 'should record all ordinary object methods calls (except __send__ and __id__)' do
    methods = Object.new.methods
    methods.each { |m| @foo.__send__(m.to_sym) unless m =~ /^__/ }
    @o.calls.length.should == (methods.length-2)
  end

  it 'should allow method return values to be stubbed' do
    @o.when(:foo).receives(:bar).return('baz')
    @foo.bar.should == 'baz'
  end
  
  it 'should allow multiple method return values to be stubbed' do
    @o.when(:foo).receives(:bar).return('baz', 'bat')
    @foo.bar.should == ['baz', 'bat']
  end

  it 'should allow method return values to be stubbed for method invocations with specific arguments' do
    @o.when(:foo).receives(:bar).with(7).return('baz')
    @foo.bar(7).should == 'baz'
  end

  it 'should not match method invocations with incorrect specific arguments' do
    @o.when(:foo).receives(:bar).with(7).return('baz')
    @foo.bar(8).should == nil
  end

  it 'should allow method return values to be stubbed for method invocations with multiple specific arguments' do
    @o.when(:foo).receives(:bar).with(7,8).return('baz')
    @foo.bar(7,8).should == 'baz'
  end
  
  it 'should allow stubbed methods to yield' do
    @o.when(:foo).receives(:bar).with(7).yield('baz')
    @foo.bar(7) do |v|
      v.should == 'baz'
    end
  end

  it 'should allow stubbed methods to yield multiple values' do
    @o.when(:foo).receives(:bar).with(7).yield('baz', 'bar')
    @foo.bar(7) do |a,b|
      a.should == 'baz'
      b.should == 'bar'
    end
  end
  
  it 'should allow stubbed methods to yield multiple times' do
    @o.when(:foo).receives(:bar).with(7).yield('baz').yield('bar')
    yields = []
    @foo.bar(7) do |a|
      yields << a
    end
    yields.should == ['baz','bar']
  end

  it 'should allow stubbed methods to yield nils' do
    @o.when(:foo).receives(:bar).yield(nil)
    called = false
    @foo.bar {|s| called = true}
    called.should == true
  end

  it 'should allow stubbed methods to raise error from string' do
    @o.when(:foo).receives(:bar).raise("you can't be serious")
    begin
      @foo.bar
    rescue RuntimeError => e
      e.message.should == "you can't be serious"
    end
  end
  
  it 'should allow stubbed methods to raise error from string' do
    @o.when(:foo).receives(:bar).raise(RuntimeError, "you can't be serious")
    begin
      @foo.bar
    rescue RuntimeError => e
      e.message.should == "you can't be serious"
    end
  end
end
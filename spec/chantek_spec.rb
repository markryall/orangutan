require File.dirname(__FILE__) + '/spec_helper'

describe 'creating ruby stubs' do
  before do
    @foo = stub(:foo)
  end

  it 'should record method calls and their parameters on a stub' do
    @foo.method1 1, 2, 3
    calls.first.should == call(:foo, :method1, 1, 2, 3)
  end

  it 'should record all ordinary object methods calls (except __send__ and __id__)' do
    methods = Object.new.methods
    methods.each { |m| @foo.__send__(m.to_sym) {} unless m =~ /^__/ }
    calls.length.should == (methods.length-2)
  end

  it 'should allow method return values to be stubbed' do
    so_when(:foo).receives(:bar).return('baz')
    @foo.bar.should == 'baz'
  end
  
  it 'should allow multiple method return values to be stubbed' do
    so_when(:foo).receives(:bar).return('baz', 'bat')
    @foo.bar.should == ['baz', 'bat']
  end

  it 'should allow method return values to be stubbed for method invocations with specific arguments' do
    so_when(:foo).receives(:bar).with(7).return('baz')
    @foo.bar(7).should == 'baz'
  end

  it 'should not match method invocations with incorrect specific arguments' do
    so_when(:foo).receives(:bar).with(7).return('baz')
    @foo.bar(8).should == nil
  end

  it 'should allow method return values to be stubbed for method invocations with multiple specific arguments' do
    so_when(:foo).receives(:bar).with(7,8).return('baz')
    @foo.bar(7,8).should == 'baz'
  end
  
  it 'should allow stubbed methods to yield' do
    so_when(:foo).receives(:bar).with(7).yield('baz')
    @foo.bar(7) do |v|
      v.should == 'baz'
    end
  end

  it 'should allow stubbed methods to yield multiple values' do
    so_when(:foo).receives(:bar).with(7).yield('baz', 'bar')
    @foo.bar(7) do |a,b|
      a.should == 'baz'
      b.should == 'bar'
    end
  end
  
  it 'should allow stubbed methods to yield multiple times' do
    so_when(:foo).receives(:bar).with(7).yield('baz').yield('bar')
    yields = []
    @foo.bar(7) do |a|
      yields << a
    end
    yields.should == ['baz','bar']
  end

  it 'should allow stubbed methods to yield nils' do
    so_when(:foo).receives(:bar).yield(nil)
    called = false
    @foo.bar {|s| called = true}
    called.should == true
  end

  it 'should allow stubbed methods to raise error from string' do
    so_when(:foo).receives(:bar).raise("you can't be serious")
    begin
      @foo.bar
    rescue RuntimeError => e
      e.message.should == "you can't be serious"
    end
  end
  
  it 'should allow stubbed methods to raise error from string' do
    so_when(:foo).receives(:bar).raise(RuntimeError, "you can't be serious")
    begin
      @foo.bar
    rescue RuntimeError => e
      e.message.should == "you can't be serious"
    end
  end
  
  it 'should allow expectations return values to be stubbed' do
    so_when(:foo, :as => :foo_expectation).receives(:bar)
    expectation(:foo_expectation).should_not be_matched
    @foo.bar
    expectation(:foo_expectation).should be_matched    
  end
  
  it 'should raise error when registering duplicate named execeptions' do
    so_when(:foo, :as => :foo_expectation).receives(:bar).return('baz')
    lambda { so_when(:foo, :as => :foo_expectation).receives(:bar).return('baz') }.should raise_error("An expectation called foo_expection was already registered")
  end
end
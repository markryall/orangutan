require 'orangutan'

describe Orangutan::Expectation do
  before do
    @e = Orangutan::Expectation.new.receives(:foo)
  end

  it 'should not match when method is different' do
    @e.matches?(:bar).should == false
  end

  it 'should match when method matches and args are unspecified' do
    @e.matches?(:foo).should == true
  end
  
  it 'should match when method matches and args match' do
    @e.with(7).matches?(:foo, 7).should == true
  end
  
  it 'should not match when method matches but args do not match' do
    @e.with(7).matches?(:foo, 8).should == false
  end

  it 'should not yield by default' do
    @e.yield_container.should == nil
  end

  it 'should yield when given a value to yield' do
    @e.yield(1).yield_container.should.not == nil
  end

  it 'should yield when given a nil value to yield' do
    @e.yield(nil).yield_container.should.not == nil
  end

  it 'should store yield_value' do
    @e.yield(1).yield_container.value.should == 1
  end
  
  it 'should store return value' do
    @e.return(1).return_value.should == 1
  end
  
  it 'should not raise by default' do
    @e.raiser.should == nil
  end
  
  it 'should store raiser' do
    @e.raise('description').raiser.should.not == nil
  end
end
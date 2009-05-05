require 'expectation'

describe Expectation do
  before do
    @e = Expectation.new.receives(:foo)
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
end
